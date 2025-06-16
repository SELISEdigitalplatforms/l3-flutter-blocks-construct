# SELISE `<blocks />` Constructᵇᵉᵗᵃ

SELISE `<blocks/>` Construct is a fully functional application blueprint designed to accelerate development with **SELISE `<blocks />`**. Pre-integrated with SELISE `<blocks />` microservices, it offers a seamless full-stack foundation, complete with essential features, prebuilt modules, and practical use cases. Whether starting fresh or enhancing an existing project, **SELISE Blocks Construct** provides a scalable framework that streamlines workflows, ensures best practices, and maximizes **SELISE `<blocks />'** capabilities.

## Live Links

- **SELISE `<blocks />` Construct** → [construct.seliseblocks.com](https://construct.seliseblocks.com)
- **SELISE `<blocks />` Cloud** → [cloud.seliseblocks.com](https://cloud.seliseblocks.com)

## Other Links

### Frontend

- **SELISE `<blocks />` CLI (NPM)** → [@seliseblocks/cli](https://www.npmjs.com/package/@seliseblocks/cli)
- **GitHub Repository** → [l3-react-blocks-construct](https://github.com/SELISEdigitalplatforms/l3-react-blocks-construct)

### Backend

- **SELISE `<blocks />` CLI (NuGet)** → [SeliseBlocks.CLI](https://www.nuget.org/packages/SeliseBlocks.CLI)
- **GitHub Repository** → [l3-net-blocks-consumer](https://github.com/SELISEdigitalplatforms/l3-net-blocks-consumer)

---

## Setting Up Blocks Construct Using CLI

Get your local machine ready to set up a full-stack project integrated with SELISE `<blocks />` services. Follow these short steps to complete the setup easily and start building right away.

<details>
  <summary><strong>1. Access SELISE Blocks Cloud </strong></summary>

#### Open Blocks Cloud

1. In your browser, go to [SELISE `<blocks />` Cloud](https://cloud.seliseblocks.com).

#### Create an Account

1. Click **Sign Up** and follow the instructions to create an account.
2. Once registered, log in with your credentials.

#### Access the Console

1. After logging in, you will land on the **Console** where you can manage projects.

</details>

---

<details>
  <summary><strong>2. Create a New Project</strong></summary>

#### Before You Begin
Make sure you have a registered domain and access to its DNS settings.

#### Create Your Project
Set up a new project in the Cloud Console.

1. In the **Console**, click **Create New Project**.
2. Enter a **unique project name**.
3. Select an **environment**:
   - Choose either **Sandbox** or **Production**.
   - The page will expand to display the **domain input field**.
4. (Optional) Enable **Cookie Domain**:
   - Check the box to see the **cookie domain in use**.
   - Follow the provided instructions for DNS settings.
5. Click **Create** to initialize the project.
6. The Console will update to display your project.

</details>

---

<details>
  <summary><strong>3. Install SELISE Blocks CLI</strong></summary>

#### Check System Requirements
Make sure you have the following tools installed:

- **Node.js (v20.x or later)** → [Download Node.js](https://nodejs.org/en/download)
- **NVM (Node Version Manager)** → [Install NVM](https://www.freecodecamp.org/news/how-to-install-node-in-your-machines-macos-linux-windows/)
- **Git** → [Download Git](https://git-scm.com/downloads)

#### Install SELISE Blocks CLI
Install the CLI globally to easily scaffold your projects.

```sh
npm install -g @seliseblocks/cli
```
If you encounter permission issues on Linux/macOS:
```sh
sudo npm install -g @seliseblocks/cli
```

#### Verify Installation
Check if the CLI was installed successfully.

```sh
blocks
```
To check the installed version:
```sh
blocks v
```

</details>

---

<details>
  <summary><strong>4. Create a New Project Locally</strong></summary>

#### Initialize the Project
Use the CLI to set up your project structure and download the codebase.

```sh
blocks new <platform> <folder-name>
```
- Replace `<platform>` with either `web`, `mobile`.
- Replace `<folder-name>` with your preferred local folder name.

For example, to create a mobile project in a folder named 'my-project', your command line should look like this `blocks new mobile 'my-project'`

#### Enter Project Details
After setup, the CLI will ask for:

1. **Project Name** – Enter the project name you used earlier when creating the project on Blocks Cloud.
3. **Project Key** – Copy it from your Project Dashboard.
2. **Domain** – The domain you registered earlier.

</details>

---

<details>
  <summary><strong>5. Start SELISE Blocks Construct</strong></summary>

#### Navigate to the Project Directory
Move into your project's folder.

```sh
cd <folder-name>
```
Replace `<folder-name>` with your project's folder name.

#### Start the Application Locally
To start the application, run this command:

for **stage** environment

```sh
flutter run
```

for **production** environment

```sh
flutter run --dart-define="ENV=prod"
```

</details>

---

<details>
  <summary><strong>6. Create a user and Log In</strong></summary>

#### Create a User
You’ll need at least one user account to access the application.

1. Invite a new user from the **User Management Service** in Cloud.
2. The invited user will receive an email to activate the account.
3. After activation, the user can set a password.

#### Log In to SELISE Blocks Construct in app
Open your browser:
- Go to your locally running app.
- Enter your credentials to log in.

</details>

---

## Next Steps
You are now ready to build and extend your application with **SELISE Blocks Construct**.
