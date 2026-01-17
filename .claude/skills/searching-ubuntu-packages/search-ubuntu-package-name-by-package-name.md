# Search Ubuntu package name using package name

The following are the process to search for the proper Ubuntu package name for a given Ubuntu release using a package name of a potentially different Ubuntu/Debian release:

## Step one: Identify the Ubuntu release codename of the given release

Refer to [the "Identifying Ubuntu release codename from version" document](identify-ubuntu-release-codename-from-version.md) to identify the Ubuntu release codename from the given Ubuntu version.

## Step two: Derive the search keyword from the given package name/file name

As a best practice, derive the search keyword from the given package name by removing any version numbers, special characters, or suffixes. For example, if the package name is `libexample1.2-dev`, the search keyword would be `libexample`.

## Step three: Search for the package name in the Ubuntu packages website

You can search for the package name in the Ubuntu packages website by using the following URL:

```url-template
https://packages.ubuntu.com/search?keywords=<search-keyword>&searchon=names&suite=<codename>
```

The website can return generic error response, retry at most 3 times if that happens.

You may use alternative ways to determine the package name if the above method does not yield results, such as using `apt-cache search <search-keyword>` on a system running the target Ubuntu release.

If the system supports Docker or LXD, create a ephemeral container for the task, don't forget to clean up the container after use.
