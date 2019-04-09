namespace Sample.API.Models
{
    using static Sample.API.Runtime.Extensions;
    /// <summary>workbookFilterCriteria</summary>
    public partial class MicrosoftGraphWorkbookFilterCriteria
    {

        /// <summary>
        /// <c>AfterFromJson</c> will be called after the json deserialization has finished, allowing customization of the object
        /// before it is returned. Implement this method in a partial class to enable this behavior
        /// </summary>
        /// <param name="json">The JsonNode that should be deserialized into this object.</param>
        partial void AfterFromJson(Sample.API.Runtime.Json.JsonObject json);
        /// <summary>
        /// <c>AfterToJson</c> will be called after the json erialization has finished, allowing customization of the <see cref="Sample.API.Runtime.Json.JsonObject"
        /// /> before it is returned. Implement this method in a partial class to enable this behavior
        /// </summary>
        /// <param name="container">The JSON container that the serialization result will be placed in.</param>
        partial void AfterToJson(ref Sample.API.Runtime.Json.JsonObject container);
        /// <summary>
        /// <c>BeforeFromJson</c> will be called before the json deserialization has commenced, allowing complete customization of
        /// the object before it is deserialized.
        /// If you wish to disable the default deserialization entirely, return <c>true</c> in the <see "returnNow" /> output parameter.
        /// Implement this method in a partial class to enable this behavior.
        /// </summary>
        /// <param name="json">The JsonNode that should be deserialized into this object.</param>
        /// <param name="returnNow">Determines if the rest of the deserialization should be processed, or if the method should return
        /// instantly.</param>
        partial void BeforeFromJson(Sample.API.Runtime.Json.JsonObject json, ref bool returnNow);
        /// <summary>
        /// <c>BeforeToJson</c> will be called before the json serialization has commenced, allowing complete customization of the
        /// object before it is serialized.
        /// If you wish to disable the default serialization entirely, return <c>true</c> in the <see "returnNow" /> output parameter.
        /// Implement this method in a partial class to enable this behavior.
        /// </summary>
        /// <param name="container">The JSON container that the serialization result will be placed in.</param>
        /// <param name="returnNow">Determines if the rest of the serialization should be processed, or if the method should return
        /// instantly.</param>
        partial void BeforeToJson(ref Sample.API.Runtime.Json.JsonObject container, ref bool returnNow);
        /// <summary>
        /// Deserializes a <see cref="Sample.API.Runtime.Json.JsonNode"/> into an instance of Sample.API.Models.IMicrosoftGraphWorkbookFilterCriteria.
        /// </summary>
        /// <param name="node">a <see cref="Sample.API.Runtime.Json.JsonNode" /> to deserialize from.</param>
        /// <returns>an instance of Sample.API.Models.IMicrosoftGraphWorkbookFilterCriteria.</returns>
        public static Sample.API.Models.IMicrosoftGraphWorkbookFilterCriteria FromJson(Sample.API.Runtime.Json.JsonNode node)
        {
            return node is Sample.API.Runtime.Json.JsonObject json ? new MicrosoftGraphWorkbookFilterCriteria(json) : null;
        }
        /// <summary>
        /// Deserializes a Sample.API.Runtime.Json.JsonObject into a new instance of <see cref="MicrosoftGraphWorkbookFilterCriteria" />.
        /// </summary>
        /// <param name="json">A Sample.API.Runtime.Json.JsonObject instance to deserialize from.</param>
        internal MicrosoftGraphWorkbookFilterCriteria(Sample.API.Runtime.Json.JsonObject json)
        {
            bool returnNow = false;
            BeforeFromJson(json, ref returnNow);
            if (returnNow)
            {
                return;
            }
            {_icon = If( json?.PropertyT<Sample.API.Runtime.Json.JsonObject>("icon"), out var __jsonIcon) ? Sample.API.Models.MicrosoftGraphWorkbookIcon.FromJson(__jsonIcon) : Icon;}
            {_color = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("color"), out var __jsonColor) ? (string)__jsonColor : (string)Color;}
            {_criterion1 = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("criterion1"), out var __jsonCriterion1) ? (string)__jsonCriterion1 : (string)Criterion1;}
            {_criterion2 = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("criterion2"), out var __jsonCriterion2) ? (string)__jsonCriterion2 : (string)Criterion2;}
            {_dynamicCriteria = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("dynamicCriteria"), out var __jsonDynamicCriteria) ? (string)__jsonDynamicCriteria : (string)DynamicCriteria;}
            {_filterOn = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("filterOn"), out var __jsonFilterOn) ? (string)__jsonFilterOn : (string)FilterOn;}
            {_operator = If( json?.PropertyT<Sample.API.Runtime.Json.JsonString>("operator"), out var __jsonOperator) ? (string)__jsonOperator : (string)Operator;}
            {_values = If( json?.PropertyT<Sample.API.Runtime.Json.JsonObject>("values"), out var __jsonValues) ? Sample.API.Models.MicrosoftGraphJson.FromJson(__jsonValues) : Values;}
            AfterFromJson(json);
        }
        /// <summary>
        /// Serializes this instance of <see cref="MicrosoftGraphWorkbookFilterCriteria" /> into a <see cref="Sample.API.Runtime.Json.JsonNode"
        /// />.
        /// </summary>
        /// <param name="container">The <see cref="Sample.API.Runtime.Json.JsonObject"/> container to serialize this object into. If the caller
        /// passes in <c>null</c>, a new instance will be created and returned to the caller.</param>
        /// <param name="serializationMode">Allows the caller to choose the depth of the serialization. See <see cref="Sample.API.Runtime.SerializationMode"/>.</param>
        /// <returns>
        /// a serialized instance of <see cref="MicrosoftGraphWorkbookFilterCriteria" /> as a <see cref="Sample.API.Runtime.Json.JsonNode" />.
        /// </returns>
        public Sample.API.Runtime.Json.JsonNode ToJson(Sample.API.Runtime.Json.JsonObject container, Sample.API.Runtime.SerializationMode serializationMode)
        {
            container = container ?? new Sample.API.Runtime.Json.JsonObject();

            bool returnNow = false;
            BeforeToJson(ref container, ref returnNow);
            if (returnNow)
            {
                return container;
            }
            AddIf( null != Icon ? (Sample.API.Runtime.Json.JsonNode) Icon.ToJson(null,serializationMode) : null, "icon" ,container.Add );
            AddIf( null != (((object)Color)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(Color.ToString()) : null, "color" ,container.Add );
            AddIf( null != (((object)Criterion1)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(Criterion1.ToString()) : null, "criterion1" ,container.Add );
            AddIf( null != (((object)Criterion2)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(Criterion2.ToString()) : null, "criterion2" ,container.Add );
            AddIf( null != (((object)DynamicCriteria)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(DynamicCriteria.ToString()) : null, "dynamicCriteria" ,container.Add );
            AddIf( null != (((object)FilterOn)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(FilterOn.ToString()) : null, "filterOn" ,container.Add );
            AddIf( null != (((object)Operator)?.ToString()) ? (Sample.API.Runtime.Json.JsonNode) new Sample.API.Runtime.Json.JsonString(Operator.ToString()) : null, "operator" ,container.Add );
            AddIf( null != Values ? (Sample.API.Runtime.Json.JsonNode) Values.ToJson(null,serializationMode) : null, "values" ,container.Add );
            AfterToJson(ref container);
            return container;
        }
    }
}