# rosinstall_credentials_action
Inject credentials data to rosinstall file. This way wstool can clone private repositories. It is useful for CI pipelines in SSH keys are not deployed to runner machine.

# Description
Rosinstall file is used to tell wstool which additional dependencies need to be installed.
If you need to install private ROS package `private_ros_pkg` from `https://github.com/user_name/private_ros_pkg.git` your `*.rosinstall` file would look something like
```yml
- git:
  - local-name: private_ros_pkg
  - uri: 'https://github.com/user_name/private_ros_pkg.git'
  - version: master
```

This actions replaces uri parameter with one in form of
```
https://<username>:<password>@github.com/user_name/private_ros_pkg.git
```
where `<username>` and `<password>` are Username and Password used to access private repository.

# Input Parameters
Action require two mandatory parameters
- `rosinstall_file` - name of rosinstall file relative to repository's root folder
- `credentials` - credentials in form of <username>:<password>. You should store credentials as repository's secret

# Example Workfow
In your repository you have `package.rosinstall` file. Username and password to access repository defined in rosinstall file are:
- username: bobbuilder
- password: CaterpillarD350D

Create [secret](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets) 
```
bobbuilder:CaterpillarD350D
```
named `GITHUB_CREDENTIALS`.

Your workflow file would then look something like
```yml
...
steps:
  - name: Checkout Current Repository
    uses: actions/checkout@v1
  - name: Set Rosinstall Credentials
    uses: Thazz/rosinstall_credentials_action@v1
    with:
      rosinstall_file: package.rosinstall
      credentials: ${{ secrets.GITHUB_CREDENTIALS}}
...
```