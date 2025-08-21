using System.ComponentModel.DataAnnotations;

namespace AzureWebApp.Models
{
    public class Info
    {
        [Key]
        public int Id { get; set; }

        public string Column { get; set; } = string.Empty;
    }
}
