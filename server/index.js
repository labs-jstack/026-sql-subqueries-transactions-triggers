import { startTx } from "./db/startTx.js";

startTx(async (tx, createSavepoint) => {
    await tx.query('INSERT INTO customers(first_name, last_name) VALUES ($1,$2)', ['Mateus', 'Silva']);
    // SAVE POINT
    await tx.query('SAVEPOINT sp_01');
    await createSavepoint('sp_01', async () => {
        await tx.query('UPDATE bank_accounts SET balance = balance + 2000 WHERE user_id = 1;');
        await tx.query('UPDATE bank_accounts SET balance = balance - 2000 WHERE user_id = 2;');
    })
})
