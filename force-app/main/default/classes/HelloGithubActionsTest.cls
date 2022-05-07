@isTest
public with sharing class HelloGithubActionsTest {
  static testMethod void shouldSayHello(){
    Test.startTest();
        HelloGithubActions.hello();
    Test.stopTest();
  }
}
