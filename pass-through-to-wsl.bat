FOR /F "tokens=* USEBACKQ" %%F IN (`wsl hostname -I`) DO (
SET hostnameOuput=%%F
)
ECHO %hostnameOuput%

for /f "tokens=1 delims= " %%a in ("%hostnameOuput%") do set "ipaddressOfWsl=%%a"
echo %ipaddressOfWsl%

netsh interface portproxy delete v4tov4 listenport=8100 listenaddress=0.0.0.0
netsh interface portproxy delete v4tov4 listenport=8888 listenaddress=0.0.0.0
netsh interface portproxy delete v4tov4 listenport=9000 listenaddress=0.0.0.0

netsh interface portproxy add v4tov4 listenport=8100 listenaddress=0.0.0.0 connectport=8100 connectaddress=%ipaddressOfWsl%
netsh interface portproxy add v4tov4 listenport=8888 listenaddress=0.0.0.0 connectport=8888 connectaddress=%ipaddressOfWsl%
netsh interface portproxy add v4tov4 listenport=9000 listenaddress=0.0.0.0 connectport=9000 connectaddress=%ipaddressOfWsl%

PAUSE