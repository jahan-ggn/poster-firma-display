import Component from "@glimmer/component";
import { service } from "@ember/service";
import { withPluginApi } from "discourse/lib/plugin-api";

class PosterFirmaDisplay extends Component {
  @service site;

  get firmaValue() {
    const siteUserFields = this.site.user_fields;
    const post = this.args.post;
    const userFields = post.user_custom_fields || {};

    const positionField = siteUserFields.find(
      (field) => field.name === "Firma"
    );
    if (!positionField) {
      return null;
    }

    const fieldId = positionField.id;
    return userFields[`user_field_${fieldId}`] || null;
  }

  <template>
    <span class="poster-user-field" style="order:2;">
      {{this.firmaValue}}
    </span>
  </template>
}

export default {
  name: "poster-firma-display",
  initialize() {
    withPluginApi((api) => {
      api.renderAfterWrapperOutlet(
        "post-meta-data-poster-name",
        PosterFirmaDisplay
      );
    });
  },
};
