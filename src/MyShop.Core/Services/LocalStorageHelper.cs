using System;
using System.IO;
using System.Text.Json;

namespace MyShop.Core.Services
{
    public static class LocalStorageHelper
    {
        private static readonly bool _isPackaged;
        private static readonly string _appFolder;

        static LocalStorageHelper()
        {
            _isPackaged = IsPackagedApp();
            
            if (!_isPackaged)
            {
                var appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
                _appFolder = Path.Combine(appDataPath, "MyShop");

                if (!Directory.Exists(_appFolder))
                {
                    Directory.CreateDirectory(_appFolder);
                }
            }
            else
            {
                // For packaged app, we don't necessarily need _appFolder for LocalSettings
                // but we might want a similar path for other file operations if needed.
                _appFolder = string.Empty; 
            }
        }

        /// <summary>
        /// Kiểm tra app đang chạy Packaged hay Unpackaged
        /// </summary>
        private static bool IsPackagedApp()
        {
            try
            {
                // Nếu access được Package.Current thì là Packaged
                _ = Windows.ApplicationModel.Package.Current.Id.Name;
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool IsPackaged => _isPackaged;

        #region Generic Load/Save

        public static T? Load<T>(string fileName) where T : class, new()
        {
            try
            {
                if (_isPackaged)
                {
                    // Packaged: dùng LocalSettings
                    var settings = Windows.Storage.ApplicationData.Current.LocalSettings;
                    if (settings.Values.TryGetValue(fileName, out var value) && value is string json)
                    {
                        return JsonSerializer.Deserialize<T>(json) ?? new T();
                    }
                }
                else
                {
                    // Unpackaged: dùng file
                    var filePath = Path.Combine(_appFolder, fileName);
                    if (File.Exists(filePath))
                    {
                        var json = File.ReadAllText(filePath);
                        return JsonSerializer.Deserialize<T>(json) ?? new T();
                    }
                }
            }
            catch
            {
                // Return default if error
            }
            return new T();
        }

        public static void Save<T>(string fileName, T data)
        {
            try
            {
                var json = JsonSerializer.Serialize(data, new JsonSerializerOptions
                {
                    WriteIndented = true
                });

                if (_isPackaged)
                {
                    // Packaged: dùng LocalSettings
                    var settings = Windows.Storage.ApplicationData.Current.LocalSettings;
                    settings.Values[fileName] = json;
                }
                else
                {
                    // Unpackaged: dùng file
                    var filePath = Path.Combine(_appFolder, fileName);
                    File.WriteAllText(filePath, json);
                }
            }
            catch
            {
                // Log if needed
            }
        }

        public static void Delete(string fileName)
        {
            try
            {
                if (_isPackaged)
                {
                    var settings = Windows.Storage.ApplicationData.Current.LocalSettings;
                    settings.Values.Remove(fileName);
                }
                else
                {
                    var filePath = Path.Combine(_appFolder, fileName);
                    if (File.Exists(filePath))
                    {
                        File.Delete(filePath);
                    }
                }
            }
            catch
            {
                // Log if needed
            }
        }

        #endregion

        #region Simple Key-Value

        public static string? GetValue(string key)
        {
            try
            {
                if (_isPackaged)
                {
                    var settings = Windows.Storage.ApplicationData.Current.LocalSettings;
                    if (settings.Values.TryGetValue(key, out var value))
                    {
                        return value as string;
                    }
                }
                else
                {
                    var filePath = Path.Combine(_appFolder, $"{key}.txt");
                    if (File.Exists(filePath))
                    {
                        return File.ReadAllText(filePath);
                    }
                }
            }
            catch { }
            return null;
        }

        public static void SetValue(string key, string? value)
        {
            try
            {
                if (_isPackaged)
                {
                    var settings = Windows.Storage.ApplicationData.Current.LocalSettings;
                    if (value == null)
                        settings.Values.Remove(key);
                    else
                        settings.Values[key] = value;
                }
                else
                {
                    var filePath = Path.Combine(_appFolder, $"{key}.txt");
                    if (value == null)
                    {
                        if (File.Exists(filePath)) File.Delete(filePath);
                    }
                    else
                    {
                        File.WriteAllText(filePath, value);
                    }
                }
            }
            catch { }
        }

        #endregion
    }
}
