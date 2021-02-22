# Adding Validators

Adding your own matcher is well [documented by the RSpec project](https://relishapp.com/rspec/rspec-expectations/v/3-10/docs/custom-matchers/define-a-custom-matcher).
What this documentation doesn't cover, however, is unit testing and cleanly
organizing your matcher code. 

To solve this, RSpec::GraphQLResponse introduced validators - code that is
called to manage the validation of a graphql response, and provide the failure
messages. Validators allow your code to be well organized, and unit tested,
while providing a clean implementation of the matcher, as shown here:
