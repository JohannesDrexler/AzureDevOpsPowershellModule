# Azure DevOps PowerShell Module

A comprehensive PowerShell module for interacting with Azure DevOps, providing cmdlets to manage projects, pipelines, repositories, work items, and more.

## Installation

### From PowerShell Gallery

The easiest way to install this module is from the PowerShell Gallery:

```powershell
Install-Module -Name AzureDevOpsPowershellModule -Repository PSGallery
```

To install for the current user only:

```powershell
Install-Module -Name AzureDevOpsPowershellModule -Repository PSGallery -Scope CurrentUser
```

### Import the Module

After installation, import the module into your PowerShell session:

```powershell
Import-Module AzureDevOpsPowershellModule
```

To verify the module is loaded, list available cmdlets:

```powershell
Get-Command -Module AzureDevOpsPowershellModule
```

### Local Installation

To install the module locally from this repository:

1. Clone the repository:
   ```powershell
   git clone https://github.com/JohannesDrexler/AzureDevOpsPowershellModule.git
   ```

2. Run the installation script:
   ```powershell
   .\Install-DevOpsModuleLocally.ps1
   ```

3. Import the module:
   ```powershell
   Import-Module AzureDevOpsPowershellModule
   ```

## Usage

For detailed documentation and examples, see the [docs](./docs) directory.

Example usage:

```powershell
# Import the module
Import-Module AzureDevOpsPowershellModule

# Use module cmdlets
Get-Command -Module AzureDevOpsPowershellModule
```

## Requirements

- PowerShell 5.0 or later
- .NET Framework 4.7.2 or later (for PowerShell Desktop)
- PowerShell 6.0+ (for PowerShell Core)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues to report bugs and suggest enhancements.

## Support

For issues, questions, or feedback, please open an issue on the [GitHub repository](https://github.com/JohannesDrexler/AzureDevOpsPowershellModule/issues).
