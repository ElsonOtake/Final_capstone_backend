<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Exo Cars - Final Capstone (Back End) <a name="about-project"></a>

**Exo Cars** is a website for renting exotic cars. It allows users to register, see the available cars and make reservations. Admin users are allowed to add and remove cars from the database.

## Front-end Repo

[Final Capstone Front End](https://github.com/mgmediaweb/final-capstone-frontend)

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://reactjs.org/">React.js</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
    <li><a href="https://rubygems.org/gems/devise/">Devise</a></li>
    <li><a href="https://jwt.io/">JWT</a></li>
    <li><a href="https://github.com/rspec/rspec-rails">RSpec Rails</a></li>
    <li><a href="https://github.com/rswag/rswag">Rswag</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **REST API**
- **Authentication**
- **[API documentation](https://swagger.io/solutions/api-documentation/)**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO -->

## 🚀 Live Demo <a name="live-demo"></a>

- [Front End Live Demo Link](https://exo-cars.herokuapp.com)

- [API documentation](https://elsonotake-backend.herokuapp.com/api-docs/index.html)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

[Ruby](https://www.ruby-lang.org/en/)

### Setup

Clone this repository to your desired folder:

using HTTPS:
```sh
  git clone https://github.com/ElsonOtake/Final_capstone_backend.git
  cd Final_capstone_backend
```

using an SSH key:
```sh
  git clone git@github.com:ElsonOtake/Final_capstone_backend.git
  cd Final_capstone_backend
```

using GitHub CLI:
```sh
  git clone gh repo clone ElsonOtake/Final_capstone_backend
  cd Final_capstone_backend
```

### Install

Add the following content to the `config/application.yml` filling in your Postgres username and password:

```sh
  DATABASE_HOST: localhost
  DATABASE_USER: your_username
  DATABASE_PASSWORD: your_password
```

Install this project with:
```sh
  bundle install
  bundle exec figaro install
  rails db:create db:migrate db:seed
```

### Usage

To run the project, execute the following command:

```sh
  rails server
```

### Run tests

To run tests, run the following command:

```sh
  rspec spec/requests
  rspec spec/models
```

To generate the API documentation:
```sh
  rake rswag:specs:swaggerize
```
[API documentation](http://localhost:3000/api-docs/index.html) address.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

👤 **Antonio Hincapié**

- GitHub: [@AntonioHincapie](https://github.com/AntonioHincapie)
- Twitter: [@MarcoHincapie](https://twitter.com/MarcoHincapie)
- LinkedIn: [antoniohincapie](https://www.linkedin.com/in/antoniohincapie/)

👤 **Elson Otake**

- GitHub: [elsonotake](https://github.com/elsonotake)
- Twitter: [@elsonotake](https://twitter.com/elsonotake)
- LinkedIn: [elsonotake](https://linkedin.com/in/elsonotake)

👤 **Giuseppe Tomasini**

- GitHub: [@GiuseppeTG](https://github.com/GiuseppeTG)
- Twitter: [@giusetomasini](https://twitter.com/giusetomasini)
- LinkedIn: [Giuseppe Tomasini](https://www.linkedin.com/in/giuseppe-tomasini-67ba101a8/)

👤 **Gonzalo A. Medina**

- GitHub: [@mgmediaweb](https://github.com/mgmediaweb)
- Twitter: [@GonzoMedinaDev](https://twitter.com/GonzoMedinaDev)
- LinkedIn: [gonzalo-medina-g](https://www.linkedin.com/in/gonzalo-medina-g/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- [ ] **Implement Postgresql date range type for bookings**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

I would like to thank:

- [Microverse](https://www.microverse.org/)
- [W3Schools](https://www.w3schools.com/)
- [Stack Overflow](https://stackoverflow.com/)

This site is based on the [design](https://www.behance.net/gallery/26425031/Vespa-Responsive-Redesign) created by [Murat Korkmaz](https://www.behance.net/muratk) on Behance, this design is under the [Creative Commons license of the design](https://creativecommons.org/licenses/by-nc/4.0/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./MIT.md) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
