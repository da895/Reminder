## Proxy for Powershell



PowerShell can be used to configure proxy settings for various purposes, including system-wide settings, specific PowerShell sessions, or individual  commands.

   

1. Setting System-Wide Proxy (using `netsh` or Registry):

   

- Using `netsh` (for WinHTTP proxy): 

  This method affects applications that rely on the WinHTTP proxy settings.

```
    netsh winhttp set proxy <proxy_server>:<port> "bypass-list=localhost;<exceptions>"
```

- Replace `<proxy_server>` and `<port>` with your proxy's address and port.

 

`<exceptions>` is an optional comma-separated list of addresses to bypass the proxy.

 

To reset: `netsh winhttp reset proxy`

 

**Modifying Registry (for Internet Explorer/Windows proxy settings):** This affects applications that use the Internet Explorer proxy settings.

```
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyEnable -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyServer -Value "http://<proxy_server>:<port>"
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name ProxyOverride -Value "<exceptions>"
```

- `ProxyEnable` (0 for disable, 1 for enable).

`ProxyServer` specifies the proxy address and port.

`ProxyOverride` lists addresses to bypass the proxy.

2. Setting Proxy for the Current PowerShell Session (Environment Variables):

   

- This method sets environment variables that some applications and tools  might use for proxy settings within the current PowerShell session.

```
    $env:HTTP_PROXY="http://<proxy_server>:<port>"
    $env:HTTPS_PROXY="http://<proxy_server>:<port>"
    $env:NO_PROXY="localhost,<exceptions>"
```

- These variables are only active for the current session.

3. Setting Proxy for Individual Commands (e.g., `Invoke-WebRequest`):

   

- Many PowerShell cmdlets, like `Invoke-WebRequest`, have a `-Proxy` parameter.

```
    Invoke-WebRequest -Uri "http://example.com" -Proxy "http://<proxy_server>:<port>"
```

- For proxies requiring authentication, use `-ProxyCredential` with `Get-Credential`:

```
    $cred = Get-Credential -Message "Enter proxy credentials"
    Invoke-WebRequest -Uri "http://example.com" -Proxy "http://<proxy_serv
```