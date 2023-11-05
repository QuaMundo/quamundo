describe('root path', () => {
  beforeEach(() => {
    cy.request('/cypress_rails_reset_state')
  })

  it.skip('visits the root path of app', () => {
    cy.visit('/')
  })
})
