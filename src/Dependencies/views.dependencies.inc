(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}
container.add('tplParser', TTemplateParserfactory.create());

container.add(
    'baseTemplate',
    TStrViewPartialFactory.create(
        container['tplParser'] as ITemplateParser,
        getCurrentDir() + '/resources/Templates/base.template.html'
    )
);

container.add('userListView', TUserListingViewFactory.create());
