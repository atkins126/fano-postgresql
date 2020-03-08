(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit UserController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /user
     *
     * See Routes/User/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TUserController = class(TController)
    private
        fUserModel : IModelReader;
    public
        constructor create(
            const view : IView;
            const params : IViewParameters;
            const userModel : IModelReader
        );

        destructor destroy(); override;

        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

    constructor TUserController.create(
        const view : IView;
        const params : IViewParameters;
        const userModel : IModelReader
    );
    begin
        inherited create(view, params);
        fUserModel := userModel;
    end;

    destructor TUserController.destroy();
    begin
        fUserModel := nil;
        inherited destroy();
    end;

    function TUserController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        fUserModel.read();
        result := inherited handleRequest(request, response, args);
    end;

end.
