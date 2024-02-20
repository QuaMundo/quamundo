describe('main menu', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  context('menu button', () => {
    beforeEach(() => {
      cy.visit('/')
      cy.getById('menu-button').as('menuButton')
      cy.getById('menu-entries').as('menuEntries')
    })
    it('hides entries on page load', () => {
      cy.get('@menuButton').should('exist')
      cy.get('@menuEntries').should('have.class', 'hidden')
    })

    it('shows entries on button click', () => {
      cy.get('@menuButton').click()
      cy.get('@menuEntries').should('not.have.class', 'hidden')
    })

    it('hides shown entries after click', () => {
      cy.get('@menuButton').click()
      cy.get('main').click()
      cy.get('@menuEntries').should('have.class', 'hidden')
    })
  })
})
