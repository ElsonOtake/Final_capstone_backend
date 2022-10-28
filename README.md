![](https://img.shields.io/badge/Microverse-blueviolet)


# FINAL CAPSTONE (BACK END)
In this project, we created a website for renting exotic cars (exo-cars). It fetches data from an API we also created and deployed on Heroku. It allows users to register with token validation, see the available cars and make reservations. Admins are allowed to add and remove cars from the database.


## Built With

- Ruby on Rails
- devise
- jwt
- rspec-rails
- rswag


## Live Demo

[API documentation](https://elsonotake-backend.herokuapp.com/api-docs/index.html)


## Getting Started

To get a local copy, follow these simple steps.

### Prerequisites

Web browser installed

### Setup

Cloning a repository

- On GitHub.com, navigate to the main page of the repository;

- Above the list of files, click "Code" button;

- Copy the URL to clone the repository. 

  - To clone the repository using HTTPS : `https://github.com/ElsonOtake/Final_capstone_backend.git`

  - To clone the repository using an SSH key, including a certificate issued by your organization's SSH certificate authority : `git@github.com:ElsonOtake/Final_capstone_backen.git`

  - To clone a repository using GitHub CLI : `gh repo clone ElsonOtake/Final_capstone_backen`

- Open Terminal;

- Change the current working directory to the location where you want the cloned directory;

- Type `git clone`, and then paste the URL you copied earlier;

- Change the current working directory to the location of your cloned directory;

- Run `bundle install`;

- Run `bundle exec figaro install`;

- Add the following content to the `config/application.yml` filling in your Postgres username and password:

  ```
  DATABASE_HOST: localhost
  DATABASE_USER: your_username
  DATABASE_PASSWORD: your_password
  ```

- Run `rails db:create db:migrate db:seed`

- Run `rails server`;


### Run tests

- Open your terminal;

- Go to application folder;

- run `rspec spec/requests` for test the requests;

- run `rspec spec/models` for test the models;

- run `rake rswag:specs:swaggerize` to generate the [API documentation](http://localhost:3000/api-docs/index.html).


## Authors

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


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).


## Show your support

Give a ⭐️ if you like this project!


## Acknowledgments

- Microverse
- W3Schools
- Stack Overflow

This site is based on the [design](https://www.behance.net/gallery/26425031/Vespa-Responsive-Redesign) created by [Murat Korkmaz](https://www.behance.net/muratk) on Behance, this design is under the [Creative Commons license of the design](https://creativecommons.org/licenses/by-nc/4.0/).


## 📝 License

This project is [MIT](./MIT.md) licensed.
