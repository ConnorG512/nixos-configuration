{
  google = {
    standard = [ "8.8.8.8" ];
  };
  
  cloudFlare = {
    standard = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    # Malware blocking: 
    malware = [ "1.1.1.2" "2606:4700:4700::1112" "1.0.0.2" "2606:4700:4700::1002" ];
    # Malware and adult content blocking: 
    malwareAdult = [ "1.1.1.3" "2606:4700:4700::1113" "1.0.0.3" "2606:4700:4700::1003" ];
  };

  quadNine = {
    # Malware Blocking DNSSEC Validation
    malwareDNSSEC = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];
    # Secured w/ECS: Malware blocking DNSSEC Validation ECS enabled:
    malwareDNSSECECS = [ "9.9.9.11" "149.112.112.11" "2620:fe::11" "2620:fe::fe:11" ];
    unsecured = [ "9.9.9.10" "149.112.112.10" "2620:fe::10" "2620:fe::fe:10" ];
  };
}
