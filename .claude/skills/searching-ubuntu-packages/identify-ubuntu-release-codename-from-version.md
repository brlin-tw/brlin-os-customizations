# Identifying Ubuntu release codename from version

You can fetch the latest mapping of Ubuntu release codenames and their corresponding version numbers using command:

```bash
curl -s https://api.launchpad.net/1.0/ubuntu/series \
    | jq '.entries[] | [{codename: .name, version: .version}]'
```

Always rely on this method when identifying the Ubuntu release codename to ensure accuracy and up-to-date information!
