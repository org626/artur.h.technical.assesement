using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AzureWebApp2.Models
{
    [Table("info")]
    public class Info
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Required]
        [Column("column")]
        public string Column { get; set; } = string.Empty;
    }
}
