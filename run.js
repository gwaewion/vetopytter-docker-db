conn = new Mongo(); 
admindb = conn.getDB("admin");
admindb.createUser({ user: "admin", pwd: "admin_password", roles: [{ role: "userAdminAnyDatabase", db: "admin" }]}); 
vldb = conn.getDB("vl");
vldb.createUser({ user: "vl", pwd: "password", roles: [ { role: "readWrite", db: "vl" }, { role: "read", db: "reporting" }]});
