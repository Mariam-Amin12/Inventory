import chai from 'chai';
import chaiHttp from 'chai-http';
import app from '../index.js'; // Adjust the path to your index.js file

chai.use(chaiHttp);
const { expect } = chai;

describe("Authentication and Authorization", () => {
  let token;

  it("should login and return a token", (done) => {
    chai.request(app)
      .post('/api/auth/login')
      .send({ email: "test@example.com", password: "password123" })
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.body).to.have.property('accessToken');
        token = res.body.accessToken;
        done();
      });
  });

  it("should access protected route with token", (done) => {
    chai.request(app)
      .get('/api/users')
      .set('Authorization', `Bearer ${token}`)
      .end((err, res) => {
        expect(res).to.have.status(200);
        done();
      });
  });

  it("should not access protected route without token", (done) => {
    chai.request(app)
      .get('/api/users')
      .end((err, res) => {
        expect(res).to.have.status(401);
        done();
      });
  });
});