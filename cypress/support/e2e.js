// Custom commands

// Parent commands
Cypress.Commands.addAll({
  getById(id) { return cy.get(`#${id}`) },

  getSubmit() { return cy.get('[type="submit"]') },

  // session for user
  loginSession(name, password) {
    cy.session([name, password], () => {
      cy.visit('/users/sign_in')
      cy.getById('user_email').type(name)
        .getById('user_password').type(password)
        .getSubmit().click()
      // FIXME: Add validation function, see: 
      // https://docs.cypress.io/api/commands/session#Validating-the-session
    })
  },
  loginSessionUser() {
    cy.loginSession('mail@example.tld', '12345678')
  },
  loginSessionRoot() {
    cy.loginSession('quamundo@example.tld', '12345678')
  },

  // log in user
  login(name, password) {
    cy.visit('/users/sign_in')
      .getById('user_email').type(name)
      .getById('user_password').type(password)
      .getSubmit().click()
  },

  loginUser() {
    cy.login('mail@example.tld', '12345678')
  },

  loginRoot() {
    cy.login('quamundo@example.tld', '12345678')
  },

  // add an user
  addUser(email, name, password) {
    cy.visit('/users/new')

    cy.getById('user_email').type(email)
    cy.getById('user_name').type(name)
    cy.getById('user_password').type(password)
    cy.getById('user_password_confirmation').type(password)
    cy.getSubmit().click()
  }
})

// Child commands
Cypress.Commands.addAll({ prevSubject: true }, {
  // show hidden elements
  unhide(elem) {
    // FIXME: use s.th. like '.invoke('show')' instead of hardcoded class
    // (didn't figure out how to use .invoke() yet)
    elem.removeClass('hidden')
    return elem
  },
})
