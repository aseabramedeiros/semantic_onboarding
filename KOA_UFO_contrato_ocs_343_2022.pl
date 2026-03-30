% ===== KOA Combined Output | contract_id: contrato_ocs_343_2022 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_343_2022_-_HD_Solucoes_(WEBCAMs).pl
% contract_id: contrato_ocs_343_2022

instance_of(contrato_ocs_343_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(hd_solucoes_tecnologicas_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_343_2022).
plays_role(hd_solucoes_tecnologicas_ltda, hired_service_provider_role, contrato_ocs_343_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_343_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_343_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_343_2022).
clause_of(clausula_quarta_ajustes_de_pagamentos, contrato_ocs_343_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_343_2022).
clause_of(clausula_sexta_garantia_dos_bens_fornecidos, contrato_ocs_343_2022).
clause_of(clausula_setima_preco, contrato_ocs_343_2022).
clause_of(clausula_oitava_pagamento, contrato_ocs_343_2022).
clause_of(clausula_nona_equilibrio_economico_financeiro_contrato, contrato_ocs_343_2022).
clause_of(clausula_decima_matriz_riscos, contrato_ocs_343_2022).
clause_of(clausula_decima_primeira_garantia_contratual, contrato_ocs_343_2022).
clause_of(clausula_decima_segunda_obrigacoes_contratado, contrato_ocs_343_2022).
clause_of(clausula_decima_terceira_conduta_etica, contrato_ocs_343_2022).
clause_of(clausula_decima_quarta_sigilo_informacoes, contrato_ocs_343_2022).
clause_of(clausula_decima_quinta_acesso_protecao_dados, contrato_ocs_343_2022).
clause_of(clausula_decima_sexta_obrigações_bndes, contrato_ocs_343_2022).
clause_of(clausula_decima_setima_equidade_genero_valorizacao_diversidade, contrato_ocs_343_2022).
clause_of(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, contrato_ocs_343_2022).
clause_of(clausula_decima_nona_penalidades, contrato_ocs_343_2022).
clause_of(clausula_vigésima_alterações_contratuais, contrato_ocs_343_2022).
clause_of(clausula_vigésima_primeira_extinção_contrato, contrato_ocs_343_2022).
clause_of(clausula_vigésima_segunda_disposições_finais, contrato_ocs_343_2022).
clause_of(clausula_vigésima_terceira_foro, contrato_ocs_343_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, hd_solucoes_tecnologicas_ltda, provide_videoconferencing_systems).
legal_relation_instance(clausula_primeira_objeto, right_to_action, hd_solucoes_tecnologicas_ltda, provide_videoconferencing_systems).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_videoconferencing_systems).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_operate_under_contract).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, perform_under_contract_duration).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, hd_solucoes_tecnologicas_ltda, execute_contract_according_to_specs).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution_according_to_specs).
legal_relation_instance(clausula_quarta_ajustes_de_pagamentos, duty_to_act, hd_solucoes_tecnologicas_ltda, apply_price_reduction_indices).
legal_relation_instance(clausula_quarta_ajustes_de_pagamentos, subjection, hd_solucoes_tecnologicas_ltda, be_subject_to_price_reduction).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_sexta_garantia_dos_bens_fornecidos, duty_to_act, hd_solucoes_tecnologicas_ltda, resolve_defects).
legal_relation_instance(clausula_sexta_garantia_dos_bens_fornecidos, duty_to_act, hd_solucoes_tecnologicas_ltda, replace_defective_goods).
legal_relation_instance(clausula_sexta_garantia_dos_bens_fornecidos, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_defect_free_goods).
legal_relation_instance(clausula_sexta_garantia_dos_bens_fornecidos, subjection, hd_solucoes_tecnologicas_ltda, warranty_coverage).
legal_relation_instance(clausula_setima_preco, no_right_to_action, hd_solucoes_tecnologicas_ltda, receive_indemnification).
legal_relation_instance(clausula_setima_preco, duty_to_act, hd_solucoes_tecnologicas_ltda, bear_burden_of_errors).
legal_relation_instance(clausula_setima_preco, duty_to_act, hd_solucoes_tecnologicas_ltda, execute_contract_object).
legal_relation_instance(clausula_setima_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_payment).
legal_relation_instance(clausula_setima_preco, subjection, hd_solucoes_tecnologicas_ltda, accept_payment_reduction).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, bndes_effect_payment).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, hd_solucoes_tecnologicas_ltda, respect_tax_legislation).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_payments).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, hd_solucoes_tecnologicas_ltda, receive_payment).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, hd_solucoes_tecnologicas_ltda, present_fiscal_document).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, hd_solucoes_tecnologicas_ltda, send_certifications).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_contrato, duty_to_act, hd_solucoes_tecnologicas_ltda, submit_price_revision_request).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_revision_request).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_contrato, no_right_to_action, hd_solucoes_tecnologicas_ltda, request_price_revision_after_deadline).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_contrato, right_to_action, hd_solucoes_tecnologicas_ltda, request_price_revision).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, initiate_price_revision).
legal_relation_instance(clausula_decima_matriz_riscos, duty_to_omit, hd_solucoes_tecnologicas_ltda, celebrate_additives).
legal_relation_instance(clausula_decima_matriz_riscos, no_right_to_action, hd_solucoes_tecnologicas_ltda, celebrate_additives).
legal_relation_instance(clausula_decima_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, identify_risks).
legal_relation_instance(clausula_decima_matriz_riscos, duty_to_act, hd_solucoes_tecnologicas_ltda, identify_risks).
legal_relation_instance(clausula_decima_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_responsibilities).
legal_relation_instance(clausula_decima_matriz_riscos, duty_to_act, hd_solucoes_tecnologicas_ltda, establish_responsibilities).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, duty_to_act, hd_solucoes_tecnologicas_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, duty_to_act, hd_solucoes_tecnologicas_ltda, obtain_new_guarantee_if_guarantor_refuses).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_deadline).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, duty_to_act, hd_solucoes_tecnologicas_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_primeira_garantia_contratual, subjection, hd_solucoes_tecnologicas_ltda, potentially_have_guarantee_presentation_deadline_extended).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, maintain_conditions_of_habilitation).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, communicate_penalties).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, repair_defects).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, repair_damages).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, pay_taxes).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, assume_full_responsibility).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, obey_instructions).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, appoint_representative).
legal_relation_instance(clausula_decima_segunda_obrigacoes_contratado, duty_to_act, hd_solucoes_tecnologicas_ltda, present_dif).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, hd_solucoes_tecnologicas_ltda, maintain_integrity_in_public_private_relations).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, hd_solucoes_tecnologicas_ltda, prevent_corruption).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, hd_solucoes_tecnologicas_ltda, offer_or_accept_undue_advantage).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, hd_solucoes_tecnologicas_ltda, allow_favored_participation).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_omit, hd_solucoes_tecnologicas_ltda, allocate_family_members).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, hd_solucoes_tecnologicas_ltda, observe_bndes_policies).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, hd_solucoes_tecnologicas_ltda, adopt_sustainable_practices).
legal_relation_instance(clausula_decima_terceira_conduta_etica, duty_to_act, hd_solucoes_tecnologicas_ltda, remove_agents_and_communicate_facts).
legal_relation_instance(clausula_decima_quarta_sigilo_informacoes, duty_to_act, hd_solucoes_tecnologicas_ltda, maintain_data_secrecy).
legal_relation_instance(clausula_decima_quarta_sigilo_informacoes, duty_to_act, hd_solucoes_tecnologicas_ltda, sign_confidentiality_agreements).
legal_relation_instance(clausula_decima_quarta_sigilo_informacoes, duty_to_act, hd_solucoes_tecnologicas_ltda, instruct_staff_to_comply).
legal_relation_instance(clausula_decima_quarta_sigilo_informacoes, duty_to_act, hd_solucoes_tecnologicas_ltda, respect_bndes_info_security_policy).
legal_relation_instance(clausula_decima_quarta_sigilo_informacoes, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_signature_of_confidentiality_agreement).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, adopt_data_security_measures).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, maintain_data_confidentiality).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, securely_store_data).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, provide_data_access_channel).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, inform_bndes_of_requests).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, maintain_data_treatment_records).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, communicate_data_incidents).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, duty_to_act, hd_solucoes_tecnologicas_ltda, eliminate_personal_data).
legal_relation_instance(clausula_decima_quinta_acesso_protecao_dados, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_recourse).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, right_to_action, hd_solucoes_tecnologicas_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager_substitute).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receipt_commission).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_access_to_ethics_code).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_sexta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, duty_to_act, hd_solucoes_tecnologicas_ltda, prove_absence_of_discrimination).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_proof_of_absence_of_discrimination).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_setima_equidade_genero_valorizacao_diversidade, disability, hd_solucoes_tecnologicas_ltda, contract_execution_without_reparation).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, duty_to_omit, hd_solucoes_tecnologicas_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, no_right_to_action, hd_solucoes_tecnologicas_ltda, no_right_to_contract_cession).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, duty_to_omit, hd_solucoes_tecnologicas_ltda, omit_credit_cession).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, no_right_to_action, hd_solucoes_tecnologicas_ltda, no_right_to_credit_cession).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, duty_to_omit, hd_solucoes_tecnologicas_ltda, omit_issuing_credit_titles).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, no_right_to_action, hd_solucoes_tecnologicas_ltda, no_right_to_issue_credit_titles).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, duty_to_omit, hd_solucoes_tecnologicas_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, no_right_to_action, hd_solucoes_tecnologicas_ltda, no_right_to_subcontracting).
legal_relation_instance(clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_of_succession).
legal_relation_instance(clausula_decima_nona_penalidades, subjection, hd_solucoes_tecnologicas_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_nona_penalidades, duty_to_act, hd_solucoes_tecnologicas_ltda, execute_contract_fully).
legal_relation_instance(clausula_decima_nona_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_nona_penalidades, right_to_action, hd_solucoes_tecnologicas_ltda, request_reconsideration_or_appeal).
legal_relation_instance(clausula_decima_nona_penalidades, duty_to_act, hd_solucoes_tecnologicas_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_nona_penalidades, duty_to_act, hd_solucoes_tecnologicas_ltda, observe_legal_obligations).
legal_relation_instance(clausula_decima_nona_penalidades, duty_to_act, hd_solucoes_tecnologicas_ltda, avoid_mora_without_justification).
legal_relation_instance(clausula_decima_nona_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_nona_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credits).
legal_relation_instance(clausula_decima_nona_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, judicially_recover_difference).
legal_relation_instance(clausula_vigésima_alterações_contratuais, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_amendment).
legal_relation_instance(clausula_vigésima_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_amendment).
legal_relation_instance(clausula_vigésima_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, claim_damages_for_refusal).
legal_relation_instance(clausula_vigésima_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_for_damages).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_mutually).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_for_breach).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_of_breach).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_if_no_area_liberation).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_after_suspension).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, unknown, terminate_contract_for_contracted_party_bankruptcy).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, unknown, terminate_contract_for_disqualification).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, unknown, terminate_contract_for_cession_breach).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, unknown, terminate_contract_for_corruption).
legal_relation_instance(clausula_vigésima_primeira_extinção_contrato, power, unknown, terminate_contract_for_dissolution).
legal_relation_instance(clausula_vigésima_segunda_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, waive_rights_due_to_omission).
legal_relation_instance(clausula_vigésima_segunda_disposições_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_any_time).
legal_relation_instance(clausula_vigésima_terceira_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, select_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_terceira_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_in_other_court).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_payment_reduction).
action_label(accept_payment_reduction, 'Accept payment reduction').
action_type(adopt_data_security_measures).
action_label(adopt_data_security_measures, 'Adopt data security measures').
action_type(adopt_sustainable_practices).
action_label(adopt_sustainable_practices, 'Adopt sustainable practices').
action_type(agree_to_contract_amendment).
action_label(agree_to_contract_amendment, 'Agree to amendment').
action_type(allocate_family_members).
action_label(allocate_family_members, 'Do not allocate family members').
action_type(allow_bndes_inspection).
action_label(allow_bndes_inspection, 'Allow BNDES Inspection').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow Central Bank access').
action_type(allow_favored_participation).
action_label(allow_favored_participation, 'Do not allow favored participation').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Alter contract manager').
action_type(analyze_price_revision_request).
action_label(analyze_price_revision_request, 'Analyze price revision request').
action_type(analyze_risks_of_succession).
action_label(analyze_risks_of_succession, 'Analyze succession risks').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_indices).
action_label(apply_price_reduction_indices, 'Apply price reduction indices').
action_type(appoint_representative).
action_label(appoint_representative, 'Appoint representative').
action_type(assume_full_responsibility).
action_label(assume_full_responsibility, 'Assume full responsibility').
action_type(avoid_mora_without_justification).
action_label(avoid_mora_without_justification, 'Avoid delay without justification').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Subject to price reduction').
action_type(bear_burden_of_errors).
action_label(bear_burden_of_errors, 'Bear burden of errors').
action_type(bndes_effect_payment).
action_label(bndes_effect_payment, 'BNDES must effect payment').
action_type(celebrate_additives).
action_label(celebrate_additives, 'Not celebrate additives').
action_type(claim_damages_for_refusal).
action_label(claim_damages_for_refusal, 'Claim damages for refusal').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate admin procedure').
action_type(communicate_data_incidents).
action_label(communicate_data_incidents, 'Communicate data incidents').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_penalties).
action_label(communicate_penalties, 'Communicate penalties').
action_type(communicate_penalty_application).
action_label(communicate_penalty_application, 'Communicate penalty application').
action_type(compensate_for_damages).
action_label(compensate_for_damages, 'Compensate for damages').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(contract_execution_without_reparation).
action_label(contract_execution_without_reparation, 'Contract execution without reparation').
action_type(deduct_credits).
action_label(deduct_credits, 'Deduct credits').
action_type(deduct_payments).
action_label(deduct_payments, 'Deduct payments').
action_type(defend_self_against_termination).
action_label(defend_self_against_termination, 'Defend against termination').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand contractual guarantee').
action_type(demand_execution_according_to_specs).
action_label(demand_execution_according_to_specs, 'Demand execution as specified').
action_type(demand_proof_of_regularity).
action_label(demand_proof_of_regularity, 'Demand proof of regularity').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_contract_manager_substitute).
action_label(designate_contract_manager_substitute, 'Designate contract manager substitute').
action_type(designate_receipt_commission).
action_label(designate_receipt_commission, 'Designate receipt commission').
action_type(eliminate_personal_data).
action_label(eliminate_personal_data, 'Eliminate personal data').
action_type(ensure_no_copyright_infringement).
action_label(ensure_no_copyright_infringement, 'Ensure no copyright infringement').
action_type(establish_responsibilities).
action_label(establish_responsibilities, 'Establish responsibilities').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract_according_to_specs).
action_label(execute_contract_according_to_specs, 'Execute contract as specified.').
action_type(execute_contract_fully).
action_label(execute_contract_fully, 'Execute contract fully').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(exercise_rights_any_time).
action_label(exercise_rights_any_time, 'Exercise rights at any time').
action_type(extend_guarantee_presentation_deadline).
action_label(extend_guarantee_presentation_deadline, 'Extend guarantee deadline').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES data instructions').
action_type(formalize_contract_amendment).
action_label(formalize_contract_amendment, 'Formalize amendment').
action_type(give_prior_notice_of_termination).
action_label(give_prior_notice_of_termination, 'Give prior notice of termination').
action_type(identify_risks).
action_label(identify_risks, 'Identify contract risks').
action_type(inform_bndes_of_requests).
action_label(inform_bndes_of_requests, 'Inform BNDES of data requests').
action_type(initiate_price_revision).
action_label(initiate_price_revision, 'Initiate price revision').
action_type(instruct_staff_to_comply).
action_label(instruct_staff_to_comply, 'Instruct staff to comply with secrecy').
action_type(judicially_recover_difference).
action_label(judicially_recover_difference, 'Judicially recover difference').
action_type(maintain_conditions_of_habilitation).
action_label(maintain_conditions_of_habilitation, 'Maintain conditions of habilitation').
action_type(maintain_data_confidentiality).
action_label(maintain_data_confidentiality, 'Maintain data confidentiality').
action_type(maintain_data_secrecy).
action_label(maintain_data_secrecy, 'Maintain data secrecy').
action_type(maintain_data_treatment_records).
action_label(maintain_data_treatment_records, 'Maintain data treatment records').
action_type(maintain_integrity_in_public_private_relations).
action_label(maintain_integrity_in_public_private_relations, 'Maintain integrity').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments').
action_type(no_right_to_contract_cession).
action_label(no_right_to_contract_cession, 'No right to contract assignment').
action_type(no_right_to_credit_cession).
action_label(no_right_to_credit_cession, 'No right to credit assignment').
action_type(no_right_to_issue_credit_titles).
action_label(no_right_to_issue_credit_titles, 'No right to issue credit titles').
action_type(no_right_to_subcontracting).
action_label(no_right_to_subcontracting, 'No right to subcontracting').
action_type(notify_of_breach).
action_label(notify_of_breach, 'Notify of breach').
action_type(notify_termination_in_writing).
action_label(notify_termination_in_writing, 'Notify termination in writing').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_bndes_policies).
action_label(observe_bndes_policies, 'Observe BNDES policies').
action_type(observe_legal_obligations).
action_label(observe_legal_obligations, 'Observe legal obligations').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(obtain_new_guarantee_if_guarantor_refuses).
action_label(obtain_new_guarantee_if_guarantor_refuses, 'Obtain new guarantee').
action_type(offer_or_accept_undue_advantage).
action_label(offer_or_accept_undue_advantage, 'Do not offer undue advantage').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract assignment').
action_type(omit_credit_cession).
action_label(omit_credit_cession, 'Omit credit assignment').
action_type(omit_issuing_credit_titles).
action_label(omit_issuing_credit_titles, 'Omit issuing credit titles').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(perform_under_contract_duration).
action_label(perform_under_contract_duration, 'Perform during contract duration').
action_type(potentially_have_guarantee_presentation_deadline_extended).
action_label(potentially_have_guarantee_presentation_deadline_extended, 'Subject to deadline extension').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(prevent_corruption).
action_label(prevent_corruption, 'Prevent corruption').
action_type(prove_absence_of_discrimination).
action_label(prove_absence_of_discrimination, 'Prove absence of discrimination').
action_type(provide_access_to_ethics_code).
action_label(provide_access_to_ethics_code, 'Provide access to ethics code').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_videoconferencing_systems).
action_label(provide_videoconferencing_systems, 'Provide videoconferencing systems').
action_type(receive_defect_free_goods).
action_label(receive_defect_free_goods, 'Receive defect-free goods').
action_type(receive_indemnification).
action_label(receive_indemnification, 'Receive indemnification').
action_type(receive_object).
action_label(receive_object, 'Receive the object').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_videoconferencing_systems).
action_label(receive_videoconferencing_systems, 'Receive videoconferencing systems').
action_type(remove_agents_and_communicate_facts).
action_label(remove_agents_and_communicate_facts, 'Remove agents and communicate').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(replace_defective_goods).
action_label(replace_defective_goods, 'Replace defective goods').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revision_after_deadline).
action_label(request_price_revision_after_deadline, 'Request price revision after deadline').
action_type(request_proof_of_absence_of_discrimination).
action_label(request_proof_of_absence_of_discrimination, 'Request proof of no discrimination').
action_type(request_reconsideration_or_appeal).
action_label(request_reconsideration_or_appeal, 'Request reconsideration/appeal').
action_type(request_signature_of_confidentiality_agreement).
action_label(request_signature_of_confidentiality_agreement, 'Request signature of confidentiality agreement').
action_type(require_data_impact_report).
action_label(require_data_impact_report, 'Require data impact report').
action_type(resolve_defects).
action_label(resolve_defects, 'Resolve defects').
action_type(respect_bndes_info_security_policy).
action_label(respect_bndes_info_security_policy, 'Respect BNDES info security policy').
action_type(respect_tax_legislation).
action_label(respect_tax_legislation, 'Respect tax legislation').
action_type(right_of_recourse).
action_label(right_of_recourse, 'Right of Recourse').
action_type(right_to_operate_under_contract).
action_label(right_to_operate_under_contract, 'Operate under contract').
action_type(securely_store_data).
action_label(securely_store_data, 'Securely store data').
action_type(select_rio_de_janeiro_court).
action_label(select_rio_de_janeiro_court, 'Select Rio de Janeiro court').
action_type(send_certifications).
action_label(send_certifications, 'Send certifications').
action_type(sign_confidentiality_agreements).
action_label(sign_confidentiality_agreements, 'Sign confidentiality agreements').
action_type(submit_price_revision_request).
action_label(submit_price_revision_request, 'Submit price revision request').
action_type(sue_in_other_court).
action_label(sue_in_other_court, 'Sue in another court').
action_type(supply_new_goods).
action_label(supply_new_goods, 'Supply new goods').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_after_suspension).
action_label(terminate_contract_after_suspension, 'Terminate after suspension').
action_type(terminate_contract_for_breach).
action_label(terminate_contract_for_breach, 'Terminate for breach').
action_type(terminate_contract_for_cession_breach).
action_label(terminate_contract_for_cession_breach, 'Terminate for cession breach').
action_type(terminate_contract_for_contracted_party_bankruptcy).
action_label(terminate_contract_for_contracted_party_bankruptcy, 'Terminate for bankruptcy').
action_type(terminate_contract_for_corruption).
action_label(terminate_contract_for_corruption, 'Terminate for corruption').
action_type(terminate_contract_for_disqualification).
action_label(terminate_contract_for_disqualification, 'Terminate if disqualified').
action_type(terminate_contract_for_dissolution).
action_label(terminate_contract_for_dissolution, 'Terminate for dissolution').
action_type(terminate_contract_force_majeure).
action_label(terminate_contract_force_majeure, 'Terminate due to force majeure').
action_type(terminate_contract_if_no_area_liberation).
action_label(terminate_contract_if_no_area_liberation, 'Terminate if area not released').
action_type(terminate_contract_mutually).
action_label(terminate_contract_mutually, 'Terminate contract mutually').
action_type(treat_data_for_publicity).
action_label(treat_data_for_publicity, 'Treat data for publicity').
action_type(waive_rights_due_to_omission).
action_label(waive_rights_due_to_omission, 'Cannot waive rights due to omission').
action_type(warranty_coverage).
action_label(warranty_coverage, 'Subject to warranty').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_343_2022).
contract_metadata(contrato_ocs_343_2022, tipo_contrato, 'CONTRATO DE FORNECIMENTO DE BENS').
contract_metadata(contrato_ocs_343_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'HD SOLUÇÕES TECNOLÓGICAS LTDA']).
contract_metadata(contrato_ocs_343_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_343_2022, contratado, 'HD SOLUÇÕES TECNOLÓGICAS LTDA').
contract_metadata(contrato_ocs_343_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_343_2022, cnpj_contratado, '39.378.032/0001-60').
contract_metadata(contrato_ocs_343_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 39/2022 - BNDES').
contract_metadata(contrato_ocs_343_2022, data_autorizacao, '04/11/2022').
contract_metadata_raw(contrato_ocs_343_2022, 'ip_ati_deset', '31/2022', 'trecho_literal').
contract_metadata_raw(contrato_ocs_343_2022, 'data_ip_ati_deset', '25/10/2022', 'trecho_literal').
contract_metadata_raw(contrato_ocs_343_2022, 'rubricas', ['1750100021', '31016000111'], 'trecho_literal').
contract_metadata(contrato_ocs_343_2022, centro_custo, 'BN30005000 - ATI/DESET').
contract_metadata(contrato_ocs_343_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_343_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_343_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto o fornecimento de sistemas de videoconferência e microfones de extensão conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 39/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_343_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 6 (seis) meses, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_343_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_343_2022, clausula_quarta_ajustes_de_pagamentos, 'CLÁUSULA QUARTA – AJUSTES DE PAGAMENTOS', 'O atraso na entrega dos equipamentos acarretará a aplicação dos índices de redução do preço, previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_343_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através da Comissão de Recebimento, mencionada na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_343_2022, clausula_sexta_garantia_dos_bens_fornecidos, 'CLÁUSULA SEXTA – GARANTIA DOS BENS FORNECIDOS', 'A garantia será de 36 (trinta e seis) meses (itens I e II), contados do recebimento definitivo dos bens em questão, salvo se a proposta (Anexo II deste Contrato) previr prazo maior, observado o disposto no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Primeiro A garantia ocorrerá sem nenhum ônus para o BNDES e será prestada sob responsabilidade do CONTRATADO, inclusive quando for necessário o transporte dos bens ou ainda o traslado e a hospedagem de técnicos do CONTRATADO ou qualquer outro tipo de serviço necessário para o cumprimento da garantia.  Parágrafo Segundo O CONTRATADO deverá solucionar todos os vícios e defeitos apresentados pelos bens, dentro do período de garantia, no prazo de 15 dias úteis (itens I e II) após a abertura do chamado, podendo substitui-los por outros bens, novos e perfeitos, que atendam às mesmas especificações estipuladas neste Contrato e em seus Anexos, no mesmo prazo para o conserto.').
contract_clause(contrato_ocs_343_2022, clausula_setima_preco, 'CLÁUSULA SÉTIMA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 1.008.402,00 (um milhão, oito mil, quatrocentos e dois reais), conforme propostas apresentadas para os Grupos 1 e 2 (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento:  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo, conforme o caso: I. complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato; ou II. reverter o excedente como lucro, sendo facultada ao BNDES a promoção de negociação com vistas a eventual prorrogação contratual.').
contract_clause(contrato_ocs_343_2022, clausula_oitava_pagamento, 'CLÁUSULA OITAVA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte do fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. descrição detalhada do objeto executado e dos respectivos valores; V. período de referência da execução do objeto; VI. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VIII. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; IX. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; X. CNPJ do tomador do serviço: 33.657.248/0001-89; XI. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; XIII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XIV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Estado diferente daquele onde se localiza o estabelecimento do BNDES adquirente do bem e destinatário da cobrança, deverá considerar a condição de não contribuinte do BNDES na emissão da nota fiscal e no recolhimento do diferencial de alíquota do ICMS, se houver. Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Estado onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.  Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.    Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_343_2022, clausula_nona_equilibrio_economico_financeiro_contrato, 'CLÁUSULA NONA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho.  Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.     Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.', 'Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho.  Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.     Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_343_2022, clausula_decima_matriz_riscos, 'CLÁUSULA DÉCIMA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_343_2022, clausula_decima_primeira_garantia_contratual, 'CLÁUSULA DÉCIMA PRIMEIRA – GARANTIA CONTRATUAL  O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 50.402,10 (cinquenta mil, quatrocentos e dois reais e dez centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 50.402,10 (cinquenta mil, quatrocentos e dois reais e dez centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_343_2022, clausula_decima_segunda_obrigacoes_contratado, 'CLÁUSULA DÉCIMA SEGUNDA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes bens fornecidos, bem como às suas dependências, nos termos do § 1° do artigo 33 da Resolução CMN n° 4.557/2017; XII. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIV. fornecer bens novos, sem uso prévio, e entregá-los em suas embalagens originais de fábrica, devidamente lacradas, acompanhados de seus manuais de uso e instalação, estando acondicionados em meio adequado, de forma a permitir completa segurança durante o transporte e a impedir seu uso ou deterioração até a entrega;', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes bens fornecidos, bem como às suas dependências, nos termos do § 1° do artigo 33 da Resolução CMN n° 4.557/2017; XII. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIV. fornecer bens novos, sem uso prévio, e entregá-los em suas embalagens originais de fábrica, devidamente lacradas, acompanhados de seus manuais de uso e instalação, estando acondicionados em meio adequado, de forma a permitir completa segurança durante o transporte e a impedir seu uso ou deterioração até a entrega.').
contract_clause(contrato_ocs_343_2022, clausula_decima_terceira_conduta_etica, 'CLÁUSULA DÉCIMA TERCEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.    Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_343_2022, clausula_decima_quarta_sigilo_informacoes, 'CLÁUSULA DÉCIMA QUARTA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_343_2022, clausula_decima_quinta_acesso_protecao_dados, 'CLÁUSULA DÉCIMA QUINTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:   I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;  II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida; III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais; IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação; V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto; VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos; VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação; VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados; IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais; X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais; XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas; XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais; XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada; XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.   Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados-LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.').
contract_clause(contrato_ocs_343_2022, clausula_decima_sexta_obrigações_bndes, 'CLÁUSULA DÉCIMA SEXTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Fernanda Pereira Goulart, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem a estiver substituindo na função; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias ao perfeito fornecimento dos bens objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_343_2022, clausula_decima_setima_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SÉTIMA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE', 'O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.').
contract_clause(contrato_ocs_343_2022, clausula_decima_oitava_cessão_contrato_crédito_sucessão_subcontratação, 'CLÁUSULA DÉCIMA OITAVA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', ' É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_343_2022, clausula_decima_nona_penalidades, 'CLÁUSULA DÉCIMA NONA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos. Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_343_2022, clausula_vigésima_alterações_contratuais, 'CLÁUSULA VIGÉSIMA – ALTERAÇÕES CONTRATUAIS', ' O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_343_2022, clausula_vigésima_primeira_extinção_contrato, 'CLÁUSULA VIGÉSIMA PRIMEIRA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_343_2022, clausula_vigésima_segunda_disposições_finais, 'CLÁUSULA VIGÉSIMA SEGUNDA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência Anexo II - Propostas Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_343_2022, clausula_vigésima_terceira_foro, 'CLÁUSULA VIGÉSIMA TERCEIRA – FORO', ' É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.').

% ===== END =====
