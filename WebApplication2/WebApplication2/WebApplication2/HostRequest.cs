//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication2
{
    using System;
    using System.Collections.Generic;
    
    public partial class HostRequest
    {
        public int ID { get; set; }
        public Nullable<int> representative_ID { get; set; }
        public Nullable<int> Manager_ID { get; set; }
        public Nullable<int> Match_ID { get; set; }
        public string Status { get; set; }
    
        public virtual ClubRepresentative ClubRepresentative { get; set; }
        public virtual StadiumManager StadiumManager { get; set; }
        public virtual Match Match { get; set; }
    }
}