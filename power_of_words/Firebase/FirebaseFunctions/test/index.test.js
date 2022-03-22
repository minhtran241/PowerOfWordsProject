const chai = require('chai');
const assert = chai.assert;
const sinon = require('sinon');
const admin = require('firebase-admin');

const test = require('firebase-functions-test')({
    databaseURL: "https://pow-350-default-rtdb.firebaseio.com",
    storageBucket: "pow-350.appspot.com",
    projectId: "pow-350",
  }, '/Users/calobhorton/Documents/GVSU/Winter 2022/CIS 350/Term Project/PowerOfWordsProject/power_of_words/Firebase/FirebaseFunctions/test/pow-350-c44f16bdc628.json');

test.mockConfig({ stripe : { key: '23wr42ewr34'}});

//const myFunctions = require('../index.js');

//const myFunctions = require('/Users/calobhorton/Documents/GVSU/Winter 2022/CIS 350/Term Project/PowerOfWordsProject/power_of_words/lib');

// const userFromFirebase = test.wrap(myFunctions._userFromFirebase);
// const get = test.wrap(myFunctions.get);
// const signIn = test.signIn(myFunctions.signIn);
// const signUp = test.signUp(myFunctions.signUp);
// const signOut = test.signOut(myFunctions.signOut);

//const data = _
// userFromFirebase(user)
// userFromFirebase(data, {
//     params: {
//         user: 'RORKX36biXSDNk6q6wgcRHUSKkC2'
//     }
// });

// userFromFirebase(data, {
//     auth: {
//         uid: 'RORKX36biXSDNk6q6wgcRHUSKkC2'
//     },
//     authType: 'USER'
// });

// userFromFirebase(data, {
//     birthday: "1999-01-01 00:00:00.000",
//     email: "dat4@gmail.com",
//     firstName: "dat",
//     gender: "male",
//     lastName:  "nguyen",
//     password: "dat123456",
//     race: "asian",
//     params: {
//         user: 'RORKX36biXSDNk6q6wgcRHUSKkC2'
//     },
//     auth: {
//         uid: 'RORKX36biXSDNk6q6wgcRHUSKkC2'
//     },
//     authType: 'USER'
// });

// we'll continue at constructing test data, using entries in database already


const forOnDelete = test.firestore.exampleDocumentSnapshot();
const forChangeUpdate = test.firestore.exampleDocumentSnapshotChange();

describe('Testing to see if get is correct', () => {
    let myFunctions;
    admin.initializeApp();

    before(() => {
        myFunctions = require('/Users/calobhorton/Documents/GVSU/Winter 2022/CIS 350/Term Project/PowerOfWordsProject/power_of_words/lib/authentication_service.dart');
    });

    after(() => {
        test.cleanup();
        admin.database().ref('messages').remove();
    });

    describe('Get information.', () => {
        it('should grab a proper userID from the database', () => {
            const snap = test.database.makeDataSnapshot('RORKX36biXSDNk6q6wgcRHUSKkC2', 'user/RORKX36biXSDNk6q6wgcRHUSKkC2');
            const wrapped = test.wrap(myFunctions.get);
            return wrapped(snap).then(() => {
                return admin.database().ref('user/RORKX36biXSDNk6q6wgcRHUSKkC2').once('value').then((createdSnap) => {
                    assert.equal(createdSnap.val(), 'RORKX36biXSDNk6q6wgcRHUSKkC2', 'dat4@gmail.com');
                });
            });
        });
    });
});