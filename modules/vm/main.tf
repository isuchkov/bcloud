resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags  # Use passed tags here

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                         = "${var.vm_name}-public-ip"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  allocation_method            = "Dynamic"
  idle_timeout_in_minutes      = 4
  domain_name_label            = "jenkins-server-${var.vm_name}"

  tags = var.tags  # Use passed tags here
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "vm-NetworkSecurityGroup"
  location            = var.location
  resource_group_name = var.resource_group_name
# Note that this rule will allow all external connections from internet to SSH port

  security_rule {
    name                       = "SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg-assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create (and display) an SSH key
resource "tls_private_key" "secureadmin_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.secureadmin_ssh.public_key_openssh
  }

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(file("${path.module}/user_data.sh"))
  tags = var.tags  # Use passed tags here
}
