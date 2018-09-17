# Dozens-API-via-Shell-Script

dynamic-ip-update.sh is works for [Dozens] DNS Record Global IP Address update.

certbot-auth-hook.sh and certbot-cleanup-hook.sh are [Certbot\(Let's encrypt\)] automation scripts for [Dozens].

## Requirements

- [Certbot\(Let's encrypt\)]
- [curl](https://curl.haxx.se/)
- [jq](https://stedolan.github.io/jq/)
- [sed](https://www.gnu.org/software/sed/)

## Usage

- `X_AUTH_USER`: Username.
- `X_AUTH_KEY`: API Key.
- `ZONE`: Zone name.
- `DOMAIN`: Domain name.
- `DEVICE`: Ethernet device.

### dynamic-ip-update.sh

```sh
$ X_AUTH_USER="johnappleseed" \
    X_AUTH_KEY="123abc456def789ghi" \
    ZONE="example.com" \
    DOMAIN="www.example.com" \
    DEVICE="eth0" \
    dynamic-ip-update.sh
```

### certbot-auth-hook.sh / certbot-cleanup-hook.sh

```sh
$ X_AUTH_USER="johnappleseed" \
    X_AUTH_KEY="123abc456def789ghi" \
    ZONE="example.com" \
    certbot certonly --non-interactive \
    --email "user@example.com" \
    --agree-tos \
    --manual
    --domains "example.com" \
    --domains "*.example.com" \
    --preferred-challenges dns \
    --manual-auth-hook "certbot-auth-hook.sh" \
    --manual-cleanup-hook "certbot-cleanup-hook.sh" \
    --manual-public-ip-logging-ok \
```

Thanks mutuki !!

[Dozens]: https://dozens.jp/
[Certbot\(Let's encrypt\)]: https://certbot.eff.org/
