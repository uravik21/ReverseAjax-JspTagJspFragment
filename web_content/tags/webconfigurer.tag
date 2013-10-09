<%@ taglib uri="core" prefix="c" %>
<%@ taglib uri="functions" prefix="fn" %>

<jsp:directive.tag body-content="empty" />
<jsp:directive.attribute name="id" required="true" />
<jsp:directive.attribute name="styleResources" />
<jsp:directive.attribute name="scriptResources" />
<jsp:directive.attribute name="directScripts" />

<jsp:useBean id="resourcesLoaded" class="java.util.HashMap" scope="request" />

<c:if test="${empty resourcesLoaded}">
	<script>
		window.resourcesUtil = window.resourcesUtil || {
			resourcesLoaded: {}			
		};
	</script>
</c:if>

<c:if test="${not empty id and not resourcesLoaded[id]}">

	<c:set var="newline" value="
	" />

	<c:set var="resourcePrefix" value="ToasterPopUp/" />

	<jsp:useBean id="styleResourcesMap" class="java.util.LinkedHashMap" />
		<c:forTokens items="${styleResources}" delims="${newline}" var="iter" varStatus="status">					
			<c:set target="${styleResourcesMap}" property="${status.index}">
				${iter}
			</c:set>
	</c:forTokens>

	<jsp:useBean id="scriptResourcesMap" class="java.util.LinkedHashMap" />
	<c:forTokens items="${scriptResources}" delims="${newline}" var="iter" varStatus="status">
		<c:set target="${scriptResourcesMap}" property="${status.index}">
			${iter}
		</c:set>
	</c:forTokens>

	<jsp:useBean id="directScriptMap" class="java.util.LinkedHashMap" />
	<c:forTokens items="${directScripts}" delims="${newline}" var="iter" varStatus="status">
		<c:set target="${directScriptMap}" property="${status.index}" value="${fn:trim(iter)}" />
	</c:forTokens>

	${newline}
	<c:forEach items="${styleResourcesMap}" var="iter">
		<link href="${iter.value}" rel="stylesheet" />${newlineToken}
	</c:forEach>
	<c:forEach items="${scriptResourcesMap}" var="iter">
		<script src="${iter.value}"></script>${newlineToken}
	</c:forEach>
	<c:forEach items="${directScriptMap}" var="iter">
		<script>${iter.value}</script>${newlineToken}
	</c:forEach>

	<script>resourcesUtil.resourcesLoaded['${id}'] = true;</script>
	<c:set target="${resourcesLoaded}" property="${id}" value="${true}" />

</c:if>

