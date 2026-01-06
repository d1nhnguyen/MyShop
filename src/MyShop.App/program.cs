using Microsoft.UI.Dispatching;
using Microsoft.UI.Xaml;
using System;
using System.IO;
using System.Threading;

namespace MyShop.App
{
    public static class Program
    {
        private static string _logPath = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "MyShop", "startup.log");

        [STAThread]
        static void Main(string[] args)
        {
            try
            {
                Directory.CreateDirectory(Path.GetDirectoryName(_logPath)!);
                Log("=== App Starting ===");
                
                Log("Initializing ComWrappers...");
                WinRT.ComWrappersSupport.InitializeComWrappers();
                Log("ComWrappers initialized successfully");

                Log("Starting Application...");
                Application.Start((p) =>
                {
                    Log("Inside Application.Start callback");
                    
                    var context = new DispatcherQueueSynchronizationContext(
                        DispatcherQueue.GetForCurrentThread());
                    SynchronizationContext.SetSynchronizationContext(context);
                    
                    Log("Creating App instance...");
                    new App();
                    Log("App instance created");
                });
            }
            catch (Exception ex)
            {
                Log($"FATAL ERROR: {ex.Message}");
                Log($"Stack: {ex.StackTrace}");
                
                if (ex.InnerException != null)
                {
                    Log($"Inner: {ex.InnerException.Message}");
                    Log($"Inner Stack: {ex.InnerException.StackTrace}");
                }
                
                throw;
            }
        }

        private static void Log(string message)
        {
            try
            {
                File.AppendAllText(_logPath, $"{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}: {message}\n");
            }
            catch { }
        }
    }
}