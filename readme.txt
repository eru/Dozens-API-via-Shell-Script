dynamicIPUpdate.sh is works for Dozens DNS Record Global IP Addtess update.

First, open dynamicIPUpdate.sh with editor application and replace below:

line 4 replace your Dozens user name into username (e.g. johnappleseed).
line 5 replace your API Key into authkey (e.g. 123abc456def789ghi).
line 6 replace your domain name into domainname (e.g. example.com).
line 7 replace your server name into servername (e.g. www.example.com).
line 8 replace your ethernet device into device (e.g. eth0).

Next, give executable mode to dynamicIPUpdate.sh and running script.

本家との違い
・グローバルIPアドレスを取得しに行くデバイスを設定するようにしました。
・DOMAINNAME = SERVERNAME の時に更新できないのを修正しました。

Thanks mutuki !!
