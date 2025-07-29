import pg from 'pg';

const {Client} = pg;

export const client = new Client({
    connectionString: 'postgres://root:root@localhost:5432/live026'
});

await client.connect();