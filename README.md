### run_pcaps.sh


This is a simple script that will run all the pcaps in a directory and it's sub directories through bro and it's local.bro script.
It outputs all the logs, by pcap in a sub folder of the the passed output directory. This subfolder is named for the date.


`bash-5.0$ ./run_pcaps.sh --data-path=/Users/user1/tmp/pcap_data --output-path=/Users/user1/tmp/pcap-output`

```
bash-5.0$ pwd && tree .
/Users/user1/tmp/pcap-output
.
└── Thu_May__2_09_23_59_EDT_2019
    ├── exercise-traffic_pcap
    │   ├── capture_loss.log
    │   ├── conn.log
    │   ├── dhcp.log
    │   ├── dns.log
    │   ├── files.log
    │   ├── http.log
    │   ├── loaded_scripts.log
    │   ├── notice.log
    │   ├── packet_filter.log
    │   ├── smtp.log
    │   ├── ssl.log
    │   ├── stats.log
    │   ├── weird.log
    │   └── x509.log
    ├── ftp_pcap
    │   ├── capture_loss.log
    │   ├── conn.log
    │   ├── files.log
    │   ├── ftp.log
    │   ├── loaded_scripts.log
    │   ├── packet_filter.log
    │   └── stats.log
    ├── nitroba_pcap
    │   ├── capture_loss.log
    │   ├── conn.log
    │   ├── dns.log
    │   ├── dpd.log
    │   ├── files.log
    │   ├── http.log
    │   ├── loaded_scripts.log
    │   ├── notice.log
    │   ├── packet_filter.log
    │   ├── sip.log
    │   ├── ssl.log
    │   ├── stats.log
    │   ├── weird.log
    │   └── x509.log
    ├── radius_localhost_pcapng
    │   ├── capture_loss.log
    │   ├── conn.log
    │   ├── loaded_scripts.log
    │   ├── packet_filter.log
    │   ├── radius.log
    │   └── stats.log
    ├── rfb_pcap
    │   ├── capture_loss.log
    │   ├── conn.log
    │   ├── loaded_scripts.log
    │   ├── packet_filter.log
    │   ├── rfb.log
    │   └── stats.log
    └── ssh_pcap
        ├── capture_loss.log
        ├── conn.log
        ├── loaded_scripts.log
        ├── notice.log
        ├── packet_filter.log
        ├── ssh.log
        └── stats.log

7 directories, 54 files
```