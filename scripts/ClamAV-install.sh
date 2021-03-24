#!/bin/bash
TIME=$(date "+%Y-%m-%d")

clear
mkdir /opt/scripts/
ls /opt /var/log

#clamav installation script
echo -e "1.Install all necessary packages\n -----------------" 
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum-config-manager --enable epel
yum clean all
yum repolist all
yum update -y
yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd clamav clamav-db clamd -y 

echo -e "2.Disabling selinux\n -------------------------" 
setenforce 0

echo -e "3.Taking backup and making changes. clamd \n -------------------------" fix
cp /etc/clamd.d/scan.conf /etc/clamd.d/scan_$TIME.conf
sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf

echo -e "4.Checking clam user \n -------------------------"
cat /etc/passwd | grep clam

echo -e "5.Checking localsocket enable \n -------------------------"
cat /etc/clamd.d/scan.conf | grep -e clamscan -e LocalSocket 

echo -e "6.Uncommenting LocalSocket  \n -------------------------"
sed -i -e '/\/run\/clamd.scan\/clamd.sock/ s/#/ /' /etc/clamd.d/scan.conf

cat /etc/clamd.d/scan.conf | grep -e clamscan -e LocalSocket 

echo -e "7. Adding cron job for virus scan"
mkdir /var/log/clamav
cat << EOF> /opt/scripts/virus_scan.sh
#!/bin/bash
DATEVAR="date +%d%m%y_%H%M%S"
clamscan -r -i ––exclude-dir="^/sys" /* > /var/log/clamav/clamav-$($DATEVAR).log && sed -i "/WARNING/d" /var/log/clamav/clamav-$($DATEVAR).log
EOF
(crontab -l 2>/dev/null; echo "30 1 * * * /opt/scripts/virus_scan.sh") | crontab -

echo -e "8. Keeping 15 days logs only"
cat << EOF > /opt/scripts/clamAV_cln.sh
FD=`find /var/log/clamav -mtime +15`
rm -rf $FD
EOF
(crontab -l 2>/dev/null; echo "0 4 * * * /opt/scripts/clamAV_cln.sh") | crontab -

echo -e "9. Verifying AV is running"
cd /opt/
wget http://www.eicar.org/download/eicar_com.zip
clamscan --infected --remove --recursive .

echo -e "10.Enable and start clamd \n -------------------------"
systemctl start clamd@scan
systemctl enable clamd@scan
systemctl status clamd@scan

echo -e "11.Taking backup and making changes. Freshclam \n -------------------------" 
cp /etc/freshclam.conf /etc/freshclam_$TIME.conf
sed -i -e "s/^Example/#Example/" /etc/freshclam.conf

echo -e "12.Running db report update \n -------------------------"
freshclam
rm -rf /var/lib/clamav/*.cld
