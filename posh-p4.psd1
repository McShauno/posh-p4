#
# Module manifest for module 'posh-p4'
#
# Generated by: Zougi
#
# Generated on: 2/29/2016
#

@{

# Script module or binary module file associated with this manifest
ModuleToProcess = 'posh-p4.psm1'

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = 'ab9ca7f0-544c-417d-b037-3475e18233fb'

# Author of this module
Author = 'Zougi'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = 'MS-PL'

# Description of the functionality provided by this module
Description = 'Perforce PowerShell integration. Prompt info and command line autocompletion'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
PowerShellHostVersion = ''

# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = '3.0'

# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = ''

# Processor architecture (None, X86, Amd64, IA64) required by this module
ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module
ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @()

# Modules to import as nested modules of the module specified in ModuleToProcess
NestedModules = @()

# Functions to export from this module
FunctionsToExport = @( 
        'TabExpansion',
        'Write-P4Prompt')

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
ModuleList = @()

# List of all files packaged with this module
FileList = @('P4prompt.ps1', 'P4TabExpansion.ps1')

# Private data to pass to the module specified in ModuleToProcess
PrivateData = ''

}

