using System;
using System.Text.Json;
using MyShop.Core.Services;

namespace MyShop.App.Services
{
    public interface IDraftService
    {
        void SaveDraft<T>(string key, T data);
        T GetDraft<T>(string key);
        void ClearDraft(string key);
        bool HasDraft(string key);
    }

    public class DraftService : IDraftService
    {
        public void SaveDraft<T>(string key, T data)
        {
            try
            {
                var json = JsonSerializer.Serialize(data);
                LocalStorageHelper.SetValue(key, json);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Failed to save draft: {ex.Message}");
            }
        }

        public T GetDraft<T>(string key)
        {
            try
            {
                var json = LocalStorageHelper.GetValue(key);
                if (!string.IsNullOrEmpty(json))
                {
                    return JsonSerializer.Deserialize<T>(json);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Failed to get draft: {ex.Message}");
            }

            return default;
        }

        public void ClearDraft(string key)
        {
            try
            {
                LocalStorageHelper.SetValue(key, null);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Failed to clear draft: {ex.Message}");
            }
        }

        public bool HasDraft(string key)
        {
            return LocalStorageHelper.GetValue(key) != null;
        }
    }
}
