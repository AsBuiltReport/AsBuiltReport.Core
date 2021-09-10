# Contributing to AsBuiltReport
Your contribution is welcomed and appreciated! Contributing to this project is as easy as:

- [Reporting a bug](https://github.com/AsBuiltReport/AsBuiltReport.Core/blob/master/Contributing.md#reporting-a-bug)
- [Discussing the current state of the code](https://github.com/AsBuiltReport/AsBuiltReport.Core/blob/master/Contributing.md#how-to-submit-a-contribution)
- Submitting a fix
- Proposing new features
- Creating a new report module

## Intro to Git and GitHub
* Make sure you have a [GitHub account](https://github.com/signup/free).
* Learning Git:
    * GitHub Help: [Good resources for Learning Git and GitHub](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
    * [Git Branching](https://learngitbranching.js.org/)

## Develop with GitHub
This project uses GitHub to host code, to track issues and feature requests, as well as accept pull requests.

### We use [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
Pull requests are the best way to propose changes to the codebase. We actively welcome your pull requests.

## Reporting a bug
### Due diligence
Before submitting a bug, or raising an issue, please do the following;
- Perform **basic troubleshooting** steps:
    - **Read the documentation.** Ensure you have read the `README` documentation within the relevant report repository. Check the `Supported Versions`, `System Requirements` and `Module Installation` sections.
    - **Make sure you're running the latest version.** If you’re not on the most recent version, your problem may have been solved already! Upgrading is always the best first step.
    - **Review dependencies.** If the release in question has other dependencies (e.g. vendor PowerShell modules) try upgrading/downgrading those as well.
    - **Use `Verbose` parameter.** Add `-Verbose` parameter to the command line to see if the issue can be identified via the output.
    - **Disable report InfoLevels.** Edit the report config and set all InfoLevels to 0. Gradually increase InfoLevel values for each section individually, until you are able to recreate the issue.
    - **Try older versions.** If you’re already on the latest release, try rolling back a few minor versions (e.g. if on 1.7, try 1.5 or 1.6) and see if the problem goes away. This will help narrow down when the problem first arose in the commit log.
- **Search the open and closed issues within the relevant repository** to make sure it’s not a current or previous known issue.

### What to include in your bug report
To make sure your bug report gets the attention it deserves, please consider the information requested below as the bare minimum; more information is almost always better! Bug reports with missing information may be ignored or pushed back to you, delaying a resolution.

Great bug reports tend to have:

- A quick summary and/or background of the issue
- Software versions you are using;
   - AsBuiltReport module versions (e.g. AsBuiltReport.Core v1.0.5 & AsBuiltReport.VMware.vSphere v1.2.1)
   - PowerShell versions (e.g. Windows PowerShell 5.1)
   - Operating System versions (e.g. Windows Server 2016 Version 1607)
- Steps to reproduce the issue;
  - Be specific
  - Provide the full command line you are executing
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## How to submit a contribution
If you wish to discuss ways in which to contribute to the AsBuiltReport project, you may raise an [issue](https://docs.github.com/en/free-pro-team@latest/github/managing-your-work-on-github/about-issues#working-with-issues) within the relevant [repository](https://github.com/AsBuiltReport), contact us via [direct message](https://powershell.slack.com/messages/D3MU9DP8S) in the [PowerShell Slack](https://powershell.slack.com) or [email us](mailto:support@asbuiltreport.com).

## Code Contributions

### Code Editor
You should use the multi-platform code editor [Visual Studio Code (VS Code)](https://docs.microsoft.com/dotnet/core/tutorials/with-visual-studio-code).

### Forks and Pull Requests

GitHub fosters collaboration through the notion of [pull requests](https://help.github.com/articles/using-pull-requests/). On GitHub, anyone can [fork](https://help.github.com/articles/fork-a-repo/) an existing repository into their own user account, where they can make private changes to their fork. To contribute these changes back into the original repository, a user simply creates a pull request in order to "request" that the changes be taken "upstream".

Additional references:

- GitHub's guide on [Forking](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/about-forks)
- GitHub's guide on [Contributing to Open Source](https://guides.github.com/activities/contributing-to-open-source/#pull-request)
- GitHub's guide on [Understanding the GitHub Flow](https://guides.github.com/introduction/flow/index.html)

### Version control branching

- Always [create a new branch](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-and-deleting-branches-within-your-repository) for your work, no matter how small.
- Avoid submitting unrelated changes (bug fixes & new features) in the same branch/pull request.
- Base your new branch off of the appropriate branch on the `dev` repository.

### Creating quality pull requests
A good quality pull request will have the following characteristics:

- When you create a pull request, include a summary about your changes in the PR description. The description is used to create change logs, so try to have the first sentence explain the benefit to end users. If the changes are related to an existing GitHub issue, please reference the issue in the PR description (e.g. Fix #11)
- It's recommended to avoid a PR with too many changes. A large PR not only stretches the review time, but also makes it much harder to identify issues. In such case, it's better to split the PR to multiple smaller ones. For large features, try to approach it in an incremental way, so that each PR won't be too big.
- Add a meaningful title of the PR describing what change you want to check in. Don't simply put: "Fix issue #5". Also don't directly use the issue title as the PR title. An issue title is to briefly describe what is wrong, while a PR title is to briefly describe what is changed. A better example is: "Add Ensure parameter to New-Item cmdlet", with "Fix #5" in the PR's body.

- Please use the present tense and imperative mood when describing your changes:

    Instead of "Adding support for Windows Server 2012 R2", write "Add support for Windows Server 2012 R2".
    Instead of "Fixed for server connection issue", write "Fix server connection issue".

- It will have a title that reflects the work within, and a summary that helps to understand the context of the change.
- There will be well written commit messages, with well crafted commits that tell the story of the development of this work.
- Ideally it will be small and easy to understand. Single commit PRs are usually easy to submit, review, and merge.
- The code contained within will meet the best practices set by the team wherever possible. If in doubt, [tweet](https://twitter.com/AsBuiltReport) or [email](mailto:support@asbuiltreport.com) us.

### Submitting pull requests
**Always create a pull request to the `dev` branch of a repository.**
1. Fork an [AsBuiltReport repository](https://github.com/AsBuiltReport). The example below uses the main AsBuiltReport.Core repository in the command examples.
2. Add `https://github.com/AsBuiltReport/AsBuiltReport.Core.git` as a remote named `upstream`.
    - `git remote add upstream https://github.com/AsBuiltReport/AsBuiltReport.Core.git`
3. Create your feature branch from `dev`.
4. Work on your feature.
    - Update `CHANGELOG.md` in the repository you have worked in with add / remove / fix / change information
    - Update `README.md` in the repository you have worked in with any new information, such as features, instructions, parameters and/or examples
5. Squash commits into one or two succinct commits.
    - `git rebase -i HEAD~n` # n being the number of previous commits to rebase
6. Ensure that your branch is up to date with `upstream/dev`.
    - `git checkout <branch>`
    - `git fetch upstream`
    - `git rebase upstream/dev`
7. Push branch to your fork.
    - `git push --force`
8. Open a Pull Request against the `dev` branch of this repository. We have Pull Requests templates in all repositories for this project. Please follow the template with each Pull Request.

Pull requests will be reviewed as soon as possible.

## Any contributions you make will be under the MIT Software License
In short, when you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project. Feel free to [contact](mailto:support@asbuiltreport.com) the maintainers if that's a concern.

## Report Issues and Bugs
GitHub issues is used to track issues and bugs. Report a bug by opening a new issue in the relevant [AsBuiltReport repository](https://github.com/AsBuiltReport).

## Submit bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## Use a Consistent Coding Style
Code contributors should follow the [PowerShell Guidelines](https://github.com/PoshCode/PowerShellPracticeAndStyle) wherever possible to ensure scripts are consistent in style.

Use [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) to check code quality against PowerShell Best Practices.

### DO
- Use [PascalCasing](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/capitalization-conventions) for all public member, type, and namespace names consisting of multiple words.
- Use custom label headers within tables, where required, to make easily readable labels.
- Favour readability over [brevity](https://www.dictionary.com/browse/brevity).
- Use [PSCustomObjects](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7) to store data that will be exported to a [PScribo](https://github.com/iainbrighton/PScribo) table. This helps with readability.
    - Use the following structure to create tables
        ```powershell
        # Create the PSCustomObject
        $myObject = [PSCustomObject]@{
            Name     = 'Tim'
            Language = 'PowerShell'
            City = 'Melbourne'
            State    = 'Victoria'
            Country = 'Australia'
        }
        # Set the table parameters - Table name, type & column widths
        # A list table is set and column widths are evenly set at 50% for each column
        $TableParams = @{
            Name = 'User Info'
            List = $true
            ColumnWidths = 50, 50
        }
        # This code snippet must be included for options to show table captions
        if ($Report.ShowTableCaptions) {
            $TableParams['Caption'] = "- $($TableParams.Name)"
        }
        # Output PSCustomObject to table using defined parameters
        $myObject | Table @TableParams
        ```
- Set `ColumnWidths` for all tables to improve formatting and readability. Try to maintain a consistent style throughout the report Cell text will word wrap. List tables should generally use column widths of 50/50.
- Sort primary object properties in alphanumeric order.
- Try to perform all safe commands (Get-*, Get API call, etc) at the start of a report script so it can easily be seen what data is being collected.
- Use comments written in English, but don't overdo it. Comments should serve to your reasoning and decision-making, not attempt to explain what a command does.
- Maintain a change log as per [these guidelines](https://keepachangelog.com/en/1.0.0/). The change log should be named `CHANGELOG.md`.

### DO NOT
- Do not include code within report scripts to install or import PowerShell modules. Dependencies should be documented under the `System Requirements` and `Module Installation` sections of the `README`.
- Do not include functions within report scripts. Individual script files should be created as a private function and be stored in the `\Src\Private` folder.

## Creating a New Report Repository

If you are interested in creating a new report for the AsBuiltReport project that does not yet exist, the information in this section details the process to create a new repository that will contain the new report.

1. Ask a [project owner](https://github.com/orgs/AsBuiltReport/people) to create a new repository for your new report under the organisation on GitHub, following the naming standard `AsBuiltReport.<Vendor>.<Product>`. In these intructions we will use an example by using HPE's Nimble Storage product, so the repository will be named `AsBuiltReport.HPE.NimbleStorage`. The project owner will create a new repository with a `master` branch and a `dev` branch, both containing a license file and nothing else in the repository. When the repository is created, make a fork of the repository and clone it to your machine using git.

2. Open the newly created report folder and create a Powershell `.psm1` file, using the same name as the root folder for the file name. In this example, the .psm1 file will be called `AsBuiltReport.HPE.NimbleStorage.psm1`. Enter the code below in to the .psm1 file (you can also copy this file from another AsBuiltReport Repository and rename it if you prefer).

```Powershell
# Get public function definition files and dot source them
$Public = @(Get-ChildItem -Path $PSScriptRoot\Src\Public\*.ps1)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Src\Private\*.ps1)

foreach ($Module in @($Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName
Export-ModuleMember -Function $Private.BaseName
```

3. Copy the .github folder from another AsBuiltReport repository in to the root of the new report folder. This file contains the default Pull Request template for the project as well as the Issue Templates for the project. These should be standard across all of the repositories for the AsBuiltReport project.

4. Copy the .vscode folder from another AsBuiltReport repository in to the root of the new report folder. This contains the Visual Studio Code style that is used for consistency across all of the repositories in the AsBuiltReport project.

5. Create the following folder structure under the root folder:

```
───Src
    └───Private
    └───Public
```

6. In the `Public` folder, create a .ps1 file named `Invoke-<ReportName>.ps1`. For example, `Invoke-AsBuiltReport.HPE.NimbleStorage.ps1`. This powershell script file will contain at least one function, with the function name being the same as the ps1 file, so in thie example the function would be named `Invoke-AsBuiltReport.HPE.NimbleStorage`

7. In the project root folder, create a JSON file, named <ReportName>.json. For example, `AsBuiltReport.HPE.NimbleStorage.json`. Copy the json configuration below in to the file as a starting point.
```json
{
    "Report": {
        "Name": "<Vendor Name> As Built Report",
        "Version": "1.0",
        "Status": "Released"
    },
    "Options": {
    },
    "Section": {
    },
    "InfoLevel": {
        "_comment_": "0 = Disabled, 1 = Summary, 2 = Adv Summary, 3 = Detailed, 4 = Adv Detailed, 5 = Comprehensive"
    },
    "HealthCheck": {
    }
}
```

8. We now need to create a Powershell module manifest file. Open a PowerShell console and change your directory to the root folder of the new report. Change the data in the example below for the `$manifest` variable to show the accurate details for your new report. Run the code below in the powershell session to create a new Powershell manifest file, which should result in a `psd1` file being created in the root folder for the new report:

```Powershell
$manifest = @{
    Path              = '.\AsBuiltReport.HPE.NimbleStorage.psd1'
    RootModule        = 'AsBuiltReport.HPE.NimbleStorage.psm1'
    Author            = 'Matthew Allford'
	Description		  = 'A PowerShell module to generate an as built report on the configuration of HPE Nimble Storage arrays.'
    FunctionsToExport = 'Invoke-AsBuiltReport.HPE.NimbleStorage'
    RequiredModules = @(
        @{
            ModuleName = 'AsBuiltReport.Core';
            ModuleVersion = '1.1.0'
        }
    )
}
New-ModuleManifest @manifest
```

9. Create a `README.md` file in the root folder. Ensure the README contains useful information before your first pull request!

10. That's the main shell for a new report repository completed! Make a Pull Request from your fork to the dev branch of the main repository for the initial commit with the main framework for the new report

## License
By contributing, you agree that your contributions will be licensed under the MIT License.
