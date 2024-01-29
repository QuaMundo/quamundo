// Custom commands

// get elements by ...
Cypress.Commands.addAll({
  getById(id) { return cy.get(`#${id}`) },
  getSubmit() { return cy.get('[type="submit"]') }
})

Cypress.Commands.addAll({
  // login user
  login(name, password) {
    cy.visit('/users/sign_in')
    cy.getById('user_email').type(name)
      .getById('user_password').type(password)
      .getSubmit().click()
  },
  loginUser() {
    cy.login('mail@example.tld', '12345678')
  },
  loginRoot() {
    cy.login('quamundo@exampler.tld', '12345678')
  },
})
