// Enable JSON Schema validator on ycw.conversations
// Usage: mongosh --nodb --file data/mongodb/enable_validator.js

(function() {
  const uri = "mongodb://localhost:27017";
  const dbName = "ycw";

  const schema = {
    $jsonSchema: {
      bsonType: "object",
      additionalProperties: false,
      required: ["conversation_id", "customer_id", "messages"],
      properties: {
        conversation_id: { bsonType: "string", pattern: "^[a-fA-F0-9]{24}$" },
        customer_id: { oneOf: [
          { bsonType: "int", minimum: 1 },
          { bsonType: "long", minimum: 1 },
          { bsonType: "double", minimum: 1 }
        ] },
        agent_id: { oneOf: [
          { bsonType: "int", minimum: 1 },
          { bsonType: "long", minimum: 1 },
          { bsonType: "double", minimum: 1 },
          { bsonType: "null" }
        ] },
        created_at: { bsonType: "date" },
        messages: {
          bsonType: "array",
          minItems: 1,
          items: {
            bsonType: "object",
            additionalProperties: false,
            required: ["sender", "timestamp", "content"],
            properties: {
              message_id: { bsonType: "string", pattern: "^[a-fA-F0-9]{24}$" },
              sender: { enum: ["customer", "agent"] },
              timestamp: { bsonType: "date" },
              content: { bsonType: "string", minLength: 1, maxLength: 4000 }
            }
          }
        }
      }
    }
  };

  const conn = new Mongo(uri);
  const db = conn.getDB(dbName);

  const collName = "conversations";
  const names = db.getCollectionNames();

  if (!names.includes(collName)) {
    print(`Creating collection '${collName}' with validator...`);
    const res = db.createCollection(collName, {
      validator: schema,
      validationLevel: "strict",
      validationAction: "error"
    });
    printjson(res);
  } else {
    print(`Applying validator to existing collection '${collName}'...`);
    const res = db.runCommand({
      collMod: collName,
      validator: schema,
      validationLevel: "strict",
      validationAction: "error"
    });
    printjson(res);
  }

  print("Done.");
})();
