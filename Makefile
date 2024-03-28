# https://github.com/AnalogJ/scrutiny/blob/master/docs/TROUBLESHOOTING_INFLUXDB.md#bring-your-own-influxdb
# https://github.com/AnalogJ/scrutiny/blob/master/docs/INSTALL_MANUAL.md
# XXX use different user?

PORTNAME=	scrutiny
DISTVERSIONPREFIX=	v
DISTVERSION=	0.8.0
CATEGORIES=	sysutils
MASTER_SITES=	https://github.com/analogj/scrutiny/releases/download/v${DISTVERSION}/:web
DISTFILES+=	scrutiny-web-frontend.tar.gz:web

MAINTAINER=	mikael@FreeBSD.org
COMMENT=	Hard Drive S.M.A.R.T Monitoring
WWW=		https://github.com/AnalogJ/scrutiny

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

#RUN_DEPENDS=	databases/influxdb2 \
#		sysutils/smartmontools

USES=		go:modules
USE_RC_SUBR=	scrutiny

GO_MODULE=	github.com/AnalogJ/scrutiny

GO_TARGET=	./collector/cmd/collector-metrics/ \
		./webapp/backend/cmd/scrutiny/

SUB_FILES+=	scrutiny-collector
PLIST_SUB=	ETCDIR=${ETCDIR}

post-patch:
	${REINPLACE_CMD} -e 's#/opt/scrutiny/config/scrutiny.db#/var/db/scrutiny/scrutiny.db#g' \
			 -e 's#/opt/scrutiny/web#${DATADIR}/web#g' \
			 ${WRKSRC}/example.scrutiny.yaml \
			 ${WRKSRC}/webapp/backend/pkg/config/config.go

	${REINPLACE_CMD} 's#/opt/scrutiny/config#${ETCDIR}#g' \
			 ${WRKSRC}/collector/cmd/collector-metrics/collector-metrics.go \
			 ${WRKSRC}/example.collector.yaml \
			 ${WRKSRC}/example.scrutiny.yaml \
			 ${WRKSRC}/webapp/backend/cmd/scrutiny/scrutiny.go \
			 ${WRKSRC}/webapp/backend/pkg/config/config.go

post-install:
	${MV} ${STAGEDIR}${PREFIX}/bin/collector-metrics ${STAGEDIR}${PREFIX}/bin/scrutiny-collector-metrics

	${MKDIR} ${STAGEDIR}${ETCDIR}
	${INSTALL_DATA} ${WRKSRC}/example.collector.yaml ${STAGEDIR}${ETCDIR}/collector.yaml.sample
	${INSTALL_DATA} ${WRKSRC}/example.scrutiny.yaml ${STAGEDIR}${ETCDIR}/scrutiny.yaml.sample

	${MKDIR} ${STAGEDIR}${DATADIR}
	(cd ${WRKDIR}/dist && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR}/web)

	${MKDIR} ${STAGEDIR}${PREFIX}/etc/cron.d
	${INSTALL_DATA} ${WRKDIR}/scrutiny-collector ${STAGEDIR}${PREFIX}/etc/cron.d/scrutiny-collector

	${MKDIR} ${STAGEDIR}/var/db/scrutiny

.include <bsd.port.mk>
