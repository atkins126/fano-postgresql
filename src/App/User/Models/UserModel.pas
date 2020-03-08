(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UserModel;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * model instance
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUserModel = class(TInjectableObject, IModelReader, IModelResultSet)
    private
        rdbmsInstance : IRdbms;
        resultSet : IRdbmsResultSet;
    public
        constructor create(const db : IRdbms);
        destructor destroy(); override;

        function read(const params : IModelParams = nil) : IModelResultSet;
        function data() : IModelResultSet;

        (*!------------------------------------------------
         * get total data
         *-----------------------------------------------
         * @return total data
         *-----------------------------------------------*)
        function count() : int64;

        (*!------------------------------------------------
         * test if in end of result set
         *-----------------------------------------------
         * @return true if no more record
         *-----------------------------------------------*)
        function eof() : boolean;

        (*!------------------------------------------------
         * move data pointer to next record
         *-----------------------------------------------
         * @return true if successful, false if no more record
         *-----------------------------------------------*)
        function next() : boolean;

        (*!------------------------------------------------
         * read data from current active record by its name
         *-----------------------------------------------
         * @return value in record
         *-----------------------------------------------*)
        function readString(const key : string) : string;
    end;

implementation

uses

    Classes,
    SysUtils;

    constructor TUserModel.create(const db : IRdbms);
    begin
        rdbmsInstance := db;
        resultSet := nil;
    end;

    destructor TUserModel.destroy();
    begin
        inherited destroy();
        rdbmsInstance := nil;
        resultSet := nil;
    end;

    function TUserModel.read(
        const params : IModelParams = nil
    ) : IModelResultSet;
    var statement : IRdbmsStatement;
    begin
        statement := rdbmsInstance.prepare('SELECT * FROM tb_users');
        resultSet := statement.execute();
        result := self;
    end;

    function TUserModel.data() : IModelResultSet;
    begin
        result := self;
    end;

    (*!------------------------------------------------
     * get total data
     *-----------------------------------------------
     * @return total data
     *-----------------------------------------------*)
    function TUserModel.count() : int64;
    begin
        result := resultSet.resultCount();
    end;

    (*!------------------------------------------------
     * test if in end of result set
     *-----------------------------------------------
     * @return true if no more record
     *-----------------------------------------------*)
    function TUserModel.eof() : boolean;
    begin
        result := resultSet.eof();
    end;

    (*!------------------------------------------------
     * move data pointer to next record
     *-----------------------------------------------
     * @return true if successful, false if no more record
     *-----------------------------------------------*)
    function TUserModel.next() : boolean;
    begin
        result := not resultSet.eof();
        resultSet.next();
    end;

    (*!------------------------------------------------
     * read data from current active record by its name
     *-----------------------------------------------
     * @return value in record
     *-----------------------------------------------*)
    function TUserModel.readString(const key : string) : string;
    begin
        result := resultSet.fields().fieldByName(key).asString;
    end;
end.
