(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

container.add(
    'db',
    TPostgreSqlDbFactory.create(
        config.getString('db.postgresql.host'),
        config.getString('db.postgresql.database'),
        config.getString('db.postgresql.username'),
        config.getString('db.postgresql.password'),
        config.getInt('db.postgresql.port')
    )
);
