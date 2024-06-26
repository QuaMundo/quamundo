describe("edit user profile", () => {
  beforeEach(() => {
    cy.request("/cypress_rails_reset_state");
    cy.loginSessionUser();
  });

  it("fails to change password w/o confirmation", () => {
    // FIXME: Hardcoded id - see db/seeds/cypress.rb
    cy.visit("/users/1/edit");
    cy.getById("user_password").type("abcdefgh");
    cy.getById("user_password_confirmation").clear();
    cy.getSubmit().click();

    cy.getById("flash-messages").within(() => {
      cy.getById("flash-alerts").should("exist");
      cy.getById("flash-notices").should("not.exist");
    });
  });

  it("fails to change password without matching confirmation", () => {
    // FIXME: Hardcoded id - see db/seeds/cypress.rb
    cy.visit("/users/1/edit");
    cy.getById("user_password").type("abcdefgh");
    cy.getById("user_password_confirmation").clear().type("12345678");
    cy.getSubmit().click();

    cy.getById("flash-messages").within(() => {
      cy.getById("flash-alerts").should("exist");
      cy.getById("flash-notices").should("not.exist");
    });
  });

  it("fails to change too short password", () => {
    // FIXME: Hardcoded id - see db/seeds/cypress.rb
    cy.visit("/users/1/edit");
    cy.getById("user_password").type("12");
    cy.getById("user_password_confirmation").clear().type("12");
    cy.getSubmit().click();

    cy.getById("flash-messages").within(() => {
      cy.getById("flash-alerts").should("exist");
      cy.getById("flash-notices").should("not.exist");
    });
  });

  it("changes password and redirects to root_path", () => {
    // FIXME: Hardcoded id - see db/seeds/cypress.rb
    cy.visit("/users/1/edit");
    cy.getById("user_password").type("12345678");
    cy.getById("user_password_confirmation").clear().type("12345678");
    cy.getSubmit().click();

    cy.getById("flash-messages").within(() => {
      cy.getById("flash-alerts").should("not.exist");
      cy.getById("flash-notices").should("exist");
    });

    cy.location("pathname").should("equal", "/");

    // FIXME: Ensure Session is not destroyed after password change
    cy.getById("menu-entries")
      .unhide()
      .within(() => {
        cy.get('a[href="/users/sign_in"]').should("not.exist");
      });
  });
});
