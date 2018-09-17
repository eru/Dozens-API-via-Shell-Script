dynamicIPUpdate.sh is works for Dozens DNS Record Global IP Addtess update.

First, open dynamicIPUpdate.sh with editor application and replace below:

line 4 replace your Dozens user name into X\_AUTH\_USER (e.g. johnappleseed).
line 5 replace your API Key into X\_AUTH\_KEY (e.g. 123abc456def789ghi).
line 6 replace your zone name into ZONE (e.g. example.com).
line 7 replace your domain name into DOMAIN (e.g. www.example.com).
line 8 replace your ethernet device into DEVICE (e.g. eth0).

Next, give executable mode to dynamicIPUpdate.sh and running script.

本家との違い
・グローバルIPアドレスを取得しに行くデバイスを設定するようにしました。
・DOMAINNAME = SERVERNAME の時に更新できないのを修正しました。

Thanks mutuki !!
