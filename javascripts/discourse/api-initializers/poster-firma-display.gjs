import { isEmpty } from "@ember/utils";
import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "poster-firma-display",
  initialize() {
    withPluginApi("1.37.3", (api) => {
      api.decorateWidget("poster-name:after", (helper) => {
        const post = helper.getModel();
        const siteUserFields = helper.attrs.user.site.user_fields;
        const userFields = post.user_custom_fields;

        const positionField = siteUserFields.find(
          (field) => field.name === "Firma"
        );

        if (positionField) {
          const fieldId = positionField.id;
          const value = userFields?.[`user_field_${fieldId}`];

          if (!isEmpty(value)) {
            return helper.h("span.poster-user-field", value);
          }
        }

        return null;
      });
    });
  },
};
