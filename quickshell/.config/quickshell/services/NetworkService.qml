import Quickshell
import Quickshell.Networking

Scope {
    id: root
    property int connectivity: Networking.connectivity
    property bool connected: availableNetworks.some(network => network.connected)
    property string networkConnectionName: root.getNetworkConnectionName()
    property list<Network> availableNetworks: root.getAvailableNetworks()


    function getAvailableNetworks(){
        let devices = Networking.devices
        let availableNetworks = []
        devices.values.forEach(device => {
            device.networks.values.forEach(network =>{
                availableNetworks.push(network)
            })

        })

        return availableNetworks
    }

    function getNetworkConnectionName(){
        return ""
    }
}
