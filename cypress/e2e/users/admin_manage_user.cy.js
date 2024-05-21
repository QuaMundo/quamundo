describe('add, edit and delete an user', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  // FIXME: add:
  //            * for non-admin user
  //            * for failing new, update

  context('an admin', () => {
    beforeEach(() => {
      cy.loginSessionRoot()
    })

    it('can add an user', () => {
      cy.addUser('abc@fg.de', 'abc', '12345678')

      cy.location('pathname').should('equal', '/users')
      cy.contains('abc@fg.de')
        .contains('abc')
      // FIXME: check flash msg
    })

    // FIXME: Try without creating user beforehand
    it('can edit an user', () => {
      cy.addUser('abc@fg.de', 'abc', '12345678')

      cy.visit('/users')
      cy.contains('div', 'abc@fg.de')
        .parent().parent().siblings()
        .within(() => {
          cy.get('[id*="menu_entries"]').unhide()
          cy.get('a[href*="edit"]').click()
        })

      cy.getById('user_email').clear().type('abx@fg.de')
      cy.getById('user_name').clear().type('xxx')
      cy.getById('user_password').clear().type('12345678')
      cy.getById('user_password_confirmation').clear().type('12345678')
      cy.getSubmit().click()

      cy.visit('/users')
      cy.contains('xxx')
      cy.contains('abx@fg.de')
      cy.contains('abc@fg.de').should('not.exist')
      cy.contains('abc').should('not.exist')
      // FIXME: check flash msg
    })

    // FIXME: Try without creating user beforehand
    it('can delete an user', () => {
      cy.addUser('abc@fg.de', 'abc', '12345678')

      cy.visit('/users/')
      cy.contains('div', 'abc@fg.de')
        .parent().parent().siblings()
        .within(() => {
          cy.get('[id*="menu_entries"]').unhide()
          cy.get('a[data-turbo-method="delete"]').click()
        })

      cy.contains('abc@fg.de').should('not.exist')
      // FIXME: check flash msg
    })
  })

  context('a non-admin', () => {
    beforeEach(() => {
      cy.loginSessionUser()
    })

    it('fails to add an user', () => {
      cy.visit('/users/new')

      cy.contains('No permission')
    })
  })
})
