<?php
/**
 * webtrees module-skeleton.
 */

namespace vendor\WebtreesModules\modulename;

use Composer\Autoload\ClassLoader;
use Fisharebest\Webtrees\Auth;
use Fisharebest\Webtrees\Filter;
use Fisharebest\Webtrees\Module\AbstractModule;

class ModuleName extends AbstractModule
{

    /** @var string location of the fancy treeview module files */
    var $directory;

    public function __construct()
    {
        parent::__construct('modulename');
        $this->directory = WT_MODULES_DIR . $this->getName();
        $this->action = Filter::get('mod_action');

        // register the namespaces
        $loader = new ClassLoader();
        $loader->addPsr4('vendor\\WebtreesModules\\modulename\\', $this->directory);
        $loader->register();
    }

    /* ****************************
     * Module configuration
     * ****************************/

    /** {@inheritdoc} */
    public function getName()
    {
        // warning: Must match (case-sensitive!) the directory name!
        return "modulename";
    }

    public function getTitle()
    {
        return "A title for the module which will be sown in modules menu.";
    }

    /** {@inheritdoc} */
    public function getDescription()
    {
        return "Some Description which will be shown in admin modules menu.";
    }

    /** {@inheritdoc} */
    public function defaultAccessLevel()
    {
        # Auth::PRIV_PRIVATE actually means public.
        # Auth::PRIV_NONE - no acces to anybody.
        return Auth::PRIV_PRIVATE;
    }
}

return new ModuleName();