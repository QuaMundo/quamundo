describe('sign_in path', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  it('refuses to login unknown user', () => {
    cy.login('unknown@user.tld', '12345678')

    cy.location('pathname').should('equal', '/users/sign_in')
    // FIXME: check flash msg
  })

  it('lets an existing user log in', () => {
    cy.loginUser()

    cy.location('pathname').should('equal', '/')
    // FIXME: check flash msg
  })

  it('refuses to log in user with invalid password', () => {
    cy.login('quamundo@example.tld', 'false_password')

    cy.location('pathname').should('equal', '/users/sign_in')
    // FIXME: check flash msg
  })
})
