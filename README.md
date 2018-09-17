# Dozens-API-via-Shell-Script

dynamicIPUpdate.sh is works for [Dozens](https://dozens.jp/) DNS Record Global IP Addtess update.

## Requirements

- [curl](https://curl.haxx.se/)
- [jq](https://stedolan.github.io/jq/)

## Usage

- `X\_AUTH\_USER`: Username.
- `X\_AUTH\_KEY`: API Key.
- `ZONE`: Zone name.
- `DOMAIN`: Domain name.
- `DEVICE`: Ethernet device.

```sh
$ X_AUTH_USER="johnappleseed" X_AUTH_KEY="123abc456def789ghi" ZONE="example.com" DOMAIN="www.example.com" DEVICE="eth0" dynamicIPUpdate.sh
```

Thanks mutuki !!
