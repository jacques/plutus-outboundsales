# Plutus Outbound Sales

Code for managing an outbound sales campaign.  Largely rough round the edges
pending signoff on Specification.


[![Author](http://img.shields.io/badge/author-@jacques-blue.svg?style=flat-square)](https://twitter.com/jacques)
[![Software License](https://img.shields.io/badge/license-MPLv2-brightgreen.svg?style=flat-square)](LICENSE)


---

### Usage

If the plugin exists the routes are injected into the router.

In your navigation (templates/basecamp/admin__header.tpl):

```
            <li class="dropdown{if $nav == "salestools"} active{/if}">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Sales Tools <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li class="dropdown-header">Outbound Sales</li>
                <li><a href="/admin/outboundsales"><i class="fa fa-fw fa-phone"></i> Outbound Calls</a></li>
                <li><a href="/admin/outboundsales/campaigns"><i class="fa fa-fw fa-trophy"></i> Outbound Campaigns</a></li>
              </ul>
            </li>
```

---

## LICENSE

The Plutus Outbound Sales Module is licensed under the [MPL v.2.0](LICENSE).
These templates are distributed under the License is distributed
on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language
governing permissions and limitations under the License.
