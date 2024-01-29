describe('sign_out', () => {
beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  context('when no one signed in', () => {
    it('shows a login link', () => {
      cy.visit('/')
      cy.get('nav').within(() => {
        cy.get('a[href="/users/sign_in"]').should('exist')
      })
    })

    it('does not show a logout link', () => {
      cy.visit('/')
      // cy.get('#logout').should('not.exist')
      cy.get('nav').within(() => {
        cy.get('a[href="/users/sign_out"]').should('not.exist')
      })
    })
  })

  context('when user is signed in', () => {
    beforeEach(() => { cy.loginUser() })

    it('does not show a login link', () => {
      cy.visit('/')
      cy.get('nav').within(() => {
        cy.get('a[href="/users/sign_in"]').should('not.exist')
      })
    })

    it('signs out user when clicked log out link', () => {
      cy.visit('/')
      cy.get('nav').within(() => {
        cy.get('a[href="/users/sign_out"]').click()
      })
      cy.location('pathname').should('equal', '/')
    })
  })
})
