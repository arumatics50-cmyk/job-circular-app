using System;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace JobAppPreview
{
    public class MainForm : Form
    {
        private HttpListener _listener;
        private Thread _serverThread;
        private int _port = 5060;
        private string _webRoot;

        public MainForm()
        {
            _webRoot = Path.Combine(AppDomain.CurrentDomain.BaseDirectory);
            InitializeUi();
            StartServer();
        }

        private void InitializeUi()
        {
            this.Text = "📱 চাকরির খবর - Mobile App Simulator";
            this.Size = new Size(540, 360);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.BackColor = Color.FromArgb(15, 23, 42); // Slate 900
            this.ForeColor = Color.White;
            this.Font = new Font("Segoe UI", 9.5f);
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;

            Label title = new Label
            {
                Text = "📱 চাকরির খবর (Job Circular App)",
                Font = new Font("Segoe UI", 15f, FontStyle.Bold),
                ForeColor = Color.FromArgb(45, 212, 191), // Teal
                Location = new Point(20, 20),
                AutoSize = true
            };
            this.Controls.Add(title);

            Label subtitle = new Label
            {
                Text = "Flutter Mobile Architecture • Interactive Simulator & Preview",
                Font = new Font("Segoe UI", 9.5f),
                ForeColor = Color.FromArgb(148, 163, 184),
                Location = new Point(22, 54),
                AutoSize = true
            };
            this.Controls.Add(subtitle);

            Panel statusPanel = new Panel
            {
                Location = new Point(20, 95),
                Size = new Size(485, 110),
                BackColor = Color.FromArgb(30, 41, 59)
            };

            Label lblStatus = new Label
            {
                Text = "● Mobile Simulator Server: RUNNING",
                Font = new Font("Segoe UI", 10f, FontStyle.Bold),
                ForeColor = Color.FromArgb(74, 222, 128),
                Location = new Point(16, 14),
                AutoSize = true
            };
            statusPanel.Controls.Add(lblStatus);

            Label lblLocal = new Label
            {
                Text = "🖥️ PC Browser: http://localhost:" + _port + "/",
                Font = new Font("Segoe UI", 9.5f),
                ForeColor = Color.White,
                Location = new Point(16, 42),
                AutoSize = true,
                Cursor = Cursors.Hand
            };
            lblLocal.Click += (s, e) => Process.Start("http://localhost:" + _port + "/");
            statusPanel.Controls.Add(lblLocal);

            string lanIp = GetLocalIp();
            Label lblPhone = new Label
            {
                Text = "📱 Phone Wi-Fi: http://" + lanIp + ":" + _port + "/ (Open on phone!)",
                Font = new Font("Segoe UI", 9.5f),
                ForeColor = Color.FromArgb(203, 213, 225),
                Location = new Point(16, 68),
                AutoSize = true
            };
            statusPanel.Controls.Add(lblPhone);
            this.Controls.Add(statusPanel);

            Button btnOpen = new Button
            {
                Text = "🌐 Open Mobile App Preview",
                Location = new Point(20, 225),
                Size = new Size(235, 45),
                BackColor = Color.FromArgb(13, 148, 136), // Teal 600
                ForeColor = Color.White,
                FlatStyle = FlatStyle.Flat,
                Font = new Font("Segoe UI", 10f, FontStyle.Bold),
                Cursor = Cursors.Hand
            };
            btnOpen.FlatAppearance.BorderSize = 0;
            btnOpen.Click += (s, e) => Process.Start("http://localhost:" + _port + "/");
            this.Controls.Add(btnOpen);

            Button btnFolder = new Button
            {
                Text = "📁 Open Flutter Code Folder",
                Location = new Point(270, 225),
                Size = new Size(235, 45),
                BackColor = Color.FromArgb(51, 65, 85),
                ForeColor = Color.White,
                FlatStyle = FlatStyle.Flat,
                Font = new Font("Segoe UI", 10f, FontStyle.Bold),
                Cursor = Cursors.Hand
            };
            btnFolder.FlatAppearance.BorderSize = 0;
            btnFolder.Click += (s, e) => Process.Start("explorer.exe", Path.GetFullPath(Path.Combine(_webRoot, "..")));
            this.Controls.Add(btnFolder);

            this.Shown += (s, e) =>
            {
                try { Process.Start("http://localhost:" + _port + "/"); } catch { }
            };

            this.FormClosing += (s, e) =>
            {
                try { if (_listener != null) _listener.Stop(); } catch { }
            };
        }

        private static string GetLocalIp()
        {
            try
            {
                foreach (var ni in NetworkInterface.GetAllNetworkInterfaces())
                {
                    if (ni.OperationalStatus == OperationalStatus.Up && ni.NetworkInterfaceType != NetworkInterfaceType.Loopback)
                    {
                        foreach (var ip in ni.GetIPProperties().UnicastAddresses)
                        {
                            if (ip.Address.AddressFamily == AddressFamily.InterNetwork)
                            {
                                return ip.Address.ToString();
                            }
                        }
                    }
                }
            }
            catch { }
            return "127.0.0.1";
        }

        private void StartServer()
        {
            _serverThread = new Thread(() =>
            {
                try
                {
                    _listener = new HttpListener();
                    _listener.Prefixes.Add("http://localhost:" + _port + "/");
                    _listener.Prefixes.Add("http://127.0.0.1:" + _port + "/");
                    _listener.Start();

                    while (_listener.IsListening)
                    {
                        var ctx = _listener.GetContext();
                        ThreadPool.QueueUserWorkItem((c) => ServeStatic((HttpListenerContext)c));
                    }
                }
                catch { }
            });
            _serverThread.IsBackground = true;
            _serverThread.Start();
        }

        private void ServeStatic(HttpListenerContext ctx)
        {
            try
            {
                string rel = ctx.Request.Url.AbsolutePath.TrimStart('/');
                if (string.IsNullOrEmpty(rel)) rel = "index.html";
                string fullPath = Path.Combine(_webRoot, rel);

                if (File.Exists(fullPath))
                {
                    byte[] bytes = File.ReadAllBytes(fullPath);
                    string ext = Path.GetExtension(fullPath).ToLowerInvariant();
                    switch (ext)
                    {
                        case ".html": ctx.Response.ContentType = "text/html; charset=utf-8"; break;
                        case ".css": ctx.Response.ContentType = "text/css; charset=utf-8"; break;
                        case ".js": ctx.Response.ContentType = "application/javascript; charset=utf-8"; break;
                        case ".json": ctx.Response.ContentType = "application/json; charset=utf-8"; break;
                        case ".png": ctx.Response.ContentType = "image/png"; break;
                        default: ctx.Response.ContentType = "application/octet-stream"; break;
                    }
                    ctx.Response.ContentLength64 = bytes.Length;
                    ctx.Response.OutputStream.Write(bytes, 0, bytes.Length);
                }
                else
                {
                    ctx.Response.StatusCode = 404;
                }
            }
            catch { }
            finally
            {
                try { ctx.Response.Close(); } catch { }
            }
        }

        [STAThread]
        public static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }
}
